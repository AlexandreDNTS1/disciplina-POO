import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error, users }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'columnNames': [],
    'propertyNames': [],
    'error': '',
  });

  void carregar(index) {
    final funcoes = [
      carregarCafes,
      carregarCervejas,
      carregarNacoes,
      carregarUsuarios,
    ];

    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'columnNames': [],
      'propertyNames': [],
    };

    funcoes[index]();
  }

  void carregarCafes() {
    var coffeeUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/coffee/random_coffee',
      queryParameters: {'size': '5'},
    );

    http.read(coffeeUri).then((jsonString) {
      var coffeeJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': coffeeJson,
        'propertyNames': ["blend_name", "origin", "variety", "notes"],
        'columnNames': ["Blend", "Origem", "Variedade", "Notas"]
      };
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'error': 'Erro ao carregar dados dos cafés.',
      };
    });
  }

  void carregarNacoes() {
    var nationUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/nation/random_nation',
      queryParameters: {'size': '5'},
    );

    http.read(nationUri).then((jsonString) {
      var nationJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': nationJson,
        'propertyNames': ["nationality", "language", "capital", "flag"],
        'columnNames': ["Nacionalidade", "Língua", "Capital", "Bandeira"]
      };
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'error': 'Erro ao carregar dados das nações.',
      };
    });
  }

  void carregarCervejas() {
    var beersUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/beer/random_beer',
      queryParameters: {'size': '5'},
    );

    http.read(beersUri).then((jsonString) {
      var beersJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': beersJson,
        'propertyNames': ["name", "style", "ibu"],
        'columnNames': ["Nome", "Estilo", "IBU"]
      };
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'error': 'Erro ao carregar dados das cervejas.',
      };
    });
  }

  void carregarUsuarios() {
    var usersUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/users/random_user',
      queryParameters: {'size': '5'},
    );

    http.read(usersUri).then((jsonString) {
      var usersJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'status': TableStatus.users,
        'dataObjects': usersJson,
        'propertyNames': ["first_name", "last_name", "email"],
        'columnNames': ["Nome", "Sobrenome", "Email"]
      };
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'error': 'Erro ao carregar dados dos usuários.',
      };
    });
  }
}

final dataService = DataService();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'imagens/welcome_image.png',
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Aperte os botões abaixo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
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
              case TableStatus.users:
                return DataTableWidget(
                  jsonObjects: value['dataObjects'],
                  propertyNames: value['propertyNames'],
                  columnNames: value['columnNames'],
                );
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
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        state.value = index;
        itemSelectedCallback(index);
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
        BottomNavigationBarItem(
          label: "Usuários",
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}

class DataTableWidget extends StatelessWidget {
  final List<dynamic> jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataTableWidget({
    required this.jsonObjects,
    required this.columnNames,
    required this.propertyNames,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columnNames.map(
        (name) => DataColumn(
          label: Expanded(
            child: Text(
              name,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ).toList(),
      rows: jsonObjects.map(
        (obj) => DataRow(
          cells: propertyNames.map(
            (propName) => DataCell(
              Text(obj[propName].toString()),
            ),
          ).toList(),
        ),
      ).toList(),
    );
  }
}
