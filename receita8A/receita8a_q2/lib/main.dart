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
    final Uri uri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: path,
      queryParameters: {'size': '10'},
    );

    final response = await http.get(uri);
    final jsonData = jsonDecode(response.body);
    return jsonData;
  }

  void loadData(int index) {
    final functions = [loadCafes, loadCervejas, loadNacoes];
    functions[index]();
  }

  void loadCafes() async {
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;

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

  void loadNacoes() async {
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;

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

  void loadCervejas() async {
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;

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
            final itemCount = value['dataObjects'].length;
            final status = value['status'];
            final isIdle = status == TableStatus.idle;
            final isLoading = status == TableStatus.loading;
            final isError = status == TableStatus.error;

            if (isError) {
              return Center(child: Text("Lascou"));
            } else if (isIdle || isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListWidget(
                jsonObjects: value['dataObjects'],
                propertyNames: value['propertyNames'],
                scrollEndedCallback: functionsMap[value['itemType']],
              );
            }
          },
        ),
        bottomNavigationBar: NewNavBar(itemSelectedCallback: dataService.loadData),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
  final Function(int) itemSelectedCallback;

  NewNavBar({required this.itemSelectedCallback});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return BottomNavigationBar(
      onTap: (index) {
        selectedIndex.value = index;
        itemSelectedCallback(index);
      },
      currentIndex: selectedIndex.value,
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
  final List<dynamic> jsonObjects;
  final List<String> propertyNames;
  final Function()? scrollEndedCallback;

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
          if (scrollEndedCallback != null) {
            scrollEndedCallback!();
          }
        }
      });
      return () {
        controller.dispose();
      };
    }, [controller]);

    return ListView.builder(
      controller: controller,
      itemCount: jsonObjects.length + 1,
      itemBuilder: (context, index) {
        if (index == jsonObjects.length) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final jsonObject = jsonObjects[index];

        return Card(
          child: ListTile(
            leading: Icon(Icons.info),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var propertyName in propertyNames)
                  Text('$propertyName: ${jsonObject[propertyName]}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
