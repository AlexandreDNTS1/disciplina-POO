import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

enum TableStatus { idle, loading, ready, error }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'columnNames': [],
    'propertyNames': [],
    'error': '',
  });

  void carregar(index) {
    final funcoes = [carregarmanga, sobre];

    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'columnNames': [],
      'propertyNames': [],
    };

    funcoes[index]();
  }

  void sobre() {
    tableStateNotifier.value = {
      'status': TableStatus.ready,
      'dataObjects': [],
      'columnNames': [],
      'propertyNames': [],
    };
  }

  void carregarmanga() {
    var mangaUri = Uri.https('api.jikan.moe', '/v4/manga', {'limit': '15'});

    http.get(mangaUri).then((response) {
      if (response.statusCode == 200) {
        var mangaJson = jsonDecode(response.body);

        tableStateNotifier.value = {
          'status': TableStatus.ready,
          'dataObjects': mangaJson['data'],
          'propertyNames': ["title", "type", "score"],
          'columnNames': ["Title", "Type", "Score"]
        };
      } else {
        throw Exception('Failed to load manga');
      }
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'error': 'Error loading manga data.',
      };
    });
  }
}

final dataService = DataService();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    dataService.carregar(0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("BUSCA MANGA"),
        ),
        body: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case TableStatus.idle:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        "Seja bem-vindo ao app de busca de manga",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                );
              case TableStatus.error:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ocorreu um erro ao carregar os dados.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      value['error'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.red,
                      ),
                    ),
                  ],
                );
              case TableStatus.loading:
                return Center(child: CircularProgressIndicator());
              case TableStatus.ready:
                final dataObjects = value['dataObjects'];
                if (dataObjects.isNotEmpty) {
                  final random = Random();
                  final randomIndex = random.nextInt(dataObjects.length);
                  final randomObject = dataObjects[randomIndex];

                  return SingleChildScrollView(
                    child: DataTableWidget(
                      jsonObjects: [randomObject],
                      columnNames: value['columnNames'],
                      propertyNames: value['propertyNames'],
                    ),
                  );
                } else {
                  return SobreWidget();
                }
              default:
                return Text("...");
            }
          },
        ),
        bottomNavigationBar: NewNavBar(itemSelectedCallback: dataService.carregar),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
  final Function(int) itemSelectedCallback;

  NewNavBar({required this.itemSelectedCallback});

  @override
  Widget build(BuildContext context) {
    var state = useState(0);

    return BottomNavigationBar(
      onTap: (index) {
        state.value = index;
        itemSelectedCallback(index);
      },
      currentIndex: state.value,
      items: const [
        BottomNavigationBarItem(
          label: "Busca",
          icon: Icon(Icons.search),
        ),
        BottomNavigationBarItem(
          label: "Favoritos",
          icon: Icon(Icons.favorite),
        ),
        BottomNavigationBarItem(
          label: "Sobre",
          icon: Icon(Icons.report),
        )
      ],
    );
  }
}

class DataTableWidget extends StatelessWidget {
  final List<dynamic> jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataTableWidget({
    this.jsonObjects = const [],
    this.columnNames = const [],
    this.propertyNames = const ["name", "style", "ibu"],
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columnNames
          .map(
            (name) => DataColumn(
              label: Text(
                name,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          )
          .toList(),
      rows: jsonObjects
          .map(
            (obj) => DataRow(
              cells: propertyNames
                  .map(
                    (propName) => DataCell(
                      Text(obj[propName].toString()),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}

class SobreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        SizedBox(height: 16),
        Center(
          child: Text(
            "Seja bem-vindo ao app de busca de manga\n\nNesse aplicativo, você poderá buscar seu manga favorito e adicioná-lo aos favoritos.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
