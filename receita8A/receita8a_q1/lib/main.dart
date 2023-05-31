import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error }
enum ItemType { beer, coffee, nation, none }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier =
      ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'itemType': ItemType.none,
  });

  Future<List<dynamic>> fetchData(String path) async {
    final uri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: path,
      queryParameters: {'size': '10'},
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonString = response.body;
      return jsonDecode(jsonString);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> loadData(int index) async {
    // Ignore the request if a request is already in progress
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;

    switch (index) {
      case 0:
        await loadCafes();
        break;
      case 1:
        await loadCervejas();
        break;
      case 2:
        await loadNacoes();
        break;
      default:
        break;
    }
  }

  Future<void> loadCafes() async {
    if (tableStateNotifier.value['itemType'] != ItemType.coffee) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': ItemType.coffee,
      };
    }

    try {
      final coffeesJson = await fetchData('api/coffee/random_coffee');

      final updatedDataObjects = [
        ...tableStateNotifier.value['dataObjects'],
        ...coffeesJson,
      ];

      tableStateNotifier.value = {
        'itemType': ItemType.coffee,
        'status': TableStatus.ready,
        'dataObjects': updatedDataObjects,
        'propertyNames': ["blend_name", "origin", "variety"],
        'columnNames': ["Nome", "Origem", "Tipo"],
      };
    } catch (e) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'itemType': ItemType.coffee,
      };
    }
  }

  Future<void> loadNacoes() async {
    if (tableStateNotifier.value['itemType'] != ItemType.nation) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': ItemType.nation,
      };
    }

    try {
      final nationsJson = await fetchData('api/nation/random_nation');

      final updatedDataObjects = [
        ...tableStateNotifier.value['dataObjects'],
        ...nationsJson,
      ];

      tableStateNotifier.value = {
        'itemType': ItemType.nation,
        'status': TableStatus.ready,
        'dataObjects': updatedDataObjects,
        'propertyNames': ["nationality", "capital", "language", "national_sport"],
        'columnNames': ["Nome", "Capital", "Idioma", "Esporte"],
      };
    } catch (e) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'itemType': ItemType.nation,
      };
    }
  }

  Future<void> loadCervejas() async {
    if (tableStateNotifier.value['itemType'] != ItemType.beer) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': ItemType.beer,
      };
    }

    try {
      final beersJson = await fetchData('api/beer/random_beer');

      final updatedDataObjects = [
        ...tableStateNotifier.value['dataObjects'],
        ...beersJson,
      ];

      tableStateNotifier.value = {
        'itemType': ItemType.beer,
        'status': TableStatus.ready,
        'dataObjects': updatedDataObjects,
        'propertyNames': ["name", "style", "ibu"],
        'columnNames': ["Nome", "Estilo", "IBU"],
      };
    } catch (e) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'itemType': ItemType.beer,
      };
    }
  }
}

final dataService = DataService();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final functionsMap = {
    ItemType.beer: dataService.loadCervejas,
    ItemType.coffee: dataService.loadCafes,
    ItemType.nation: dataService.loadNacoes,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dicas"),
        ),
        body: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case TableStatus.idle:
                return Center(child: Text("Toque algum botão abaixo..."));
              case TableStatus.loading:
                return Center(child: CircularProgressIndicator());
              case TableStatus.ready:
                return ListWidget(
                  jsonObjects: value['dataObjects'],
                  propertyNames: value['propertyNames'],
                  scrollEndedCallback: functionsMap[value['itemType']],
                );
              case TableStatus.error:
                return Text("Lascou");
              default:
                return Text("...");
            }
          },
        ),
        bottomNavigationBar: NewNavBar(itemSelectedCallback: dataService.loadData),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
  final Function(int)? itemSelectedCallback;

  NewNavBar({this.itemSelectedCallback});

  @override
  Widget build(BuildContext context) {
    final state = useState(1);

    return BottomNavigationBar(
      onTap: (index) {
        state.value = index;
        itemSelectedCallback?.call(index);
      },
      currentIndex: state.value,
      items: const [
        BottomNavigationBarItem(
          label: "Cafés",
          icon: Icon(Icons.coffee_outlined),
        ),
        BottomNavigationBarItem(
          label: "Cervejas",
          icon: Icon(Icons.local_drink_outlined),
        ),
        BottomNavigationBarItem(
          label: "Nações",
          icon: Icon(Icons.flag_outlined),
        ),
      ],
    );
  }
}

class ListWidget extends HookWidget {
  final dynamic scrollEndedCallback;
  final List jsonObjects;
  final List<String> propertyNames;

  ListWidget({
    this.jsonObjects = const [],
    this.propertyNames = const [],
    this.scrollEndedCallback,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();

    useEffect(() {
      controller.addListener(() {
        if (controller.position.pixels == controller.position.maxScrollExtent) {
          print('End reached');
          if (scrollEndedCallback is Function) {
            scrollEndedCallback();
          }
        }
      });
      return () {
        controller.dispose();
      };
    }, []);

    return ListView.builder(
      controller: controller,
      itemCount: jsonObjects.length,
      itemBuilder: (context, index) {
        final jsonObject = jsonObjects[index];

        return Card(
          child: ListTile(
            title: Text(jsonObject[propertyNames[0]]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 1; i < propertyNames.length; i++)
                  Text(jsonObject[propertyNames[i]]),
              ],
            ),
          ),
        );
      },
    );
  }
}
