import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error }

enum SortOrder { ascending, descending }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'columnNames': [],
    'propertyNames': [],
    'sortColumnIndex': -1,
    'sortOrder': SortOrder.ascending,
  });

  void carregar(index) {
    final funcoes = [
      carregarCafes,
      carregarCervejas,
      carregarNacoes,
      carregarSangue
    ];

    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'columnNames': [],
      'propertyNames': [],
      'sortColumnIndex': -1,
      'sortOrder': SortOrder.ascending,
    };

    funcoes[index]();
  }

  void carregarCafes() {
    var coffeUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/coffee/random_coffee',
        queryParameters: {'size': '5'});

    http.read(coffeUri).then((jsonString) {
      var coffeJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': coffeJson,
        'propertyNames': ["blend_name", "origin", "variety", "notes"],
        'columnNames': ["Blend", "Origem", "Variedade", "Notas"],
        'sortColumnIndex': -1,
        'sortOrder': SortOrder.ascending,
      };

      sortTable(0);
    }).catchError((e) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'propertyNames': [],
        'columnNames': [],
        'sortColumnIndex': -1,
        'sortOrder': SortOrder.ascending,
      };
    });
  }

  void carregarSangue() {
    var bloodUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/blood/random_blood',
        queryParameters: {'size': '5'});

    http.read(bloodUri).then((jsonString) {
      var bloodJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': bloodJson,
        'propertyNames': ["type", "rh_factor", "group"],
        'columnNames': ["Tipo sanguíneo", "Fator RH", "Grupo"],
        'sortColumnIndex': -1,
        'sortOrder': SortOrder.ascending,
      };

      sortTable(0);
    }).catchError((e) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'propertyNames': [],
        'columnNames': [],
        'sortColumnIndex': -1,
        'sortOrder': SortOrder.ascending,
      };
    });
  }

  //MÉTODO ASYNC/WAIT
  Future<void> carregarNacoes() async {
    var nationUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/nation/random_nation',
        queryParameters: {'size': '5'});

    var jsonString = await http.read(nationUri).catchError((e) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'propertyNames': [],
        'columnNames': [],
        'sortColumnIndex': -1,
        'sortOrder': SortOrder.ascending,
      };
    });

    var nationJson = jsonDecode(jsonString);

    tableStateNotifier.value = {
      'status': TableStatus.ready,
      'dataObjects': nationJson,
      'propertyNames': ["nationality", "language", "capital", "flag"],
      'columnNames': ["Nacionalidade", "Lingua", "Capital", "Bandeira"],
      'sortColumnIndex': -1,
      'sortOrder': SortOrder.ascending,
    };

    sortTable(0);
  }

  void carregarCervejas() {
    var beersUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/beer/random_beer',
        queryParameters: {'size': '5'});

    http.read(beersUri).then((jsonString) {
      var beersJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': beersJson,
        'propertyNames': ["name", "style", "ibu"],
        'columnNames': ["Nome", "Estilo", "IBU"],
        'sortColumnIndex': -1,
        'sortOrder': SortOrder.ascending,
      };

      sortTable(0);
    }).catchError((e) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'propertyNames': [],
        'columnNames': [],
        'sortColumnIndex': -1,
        'sortOrder': SortOrder.ascending,
      };
    });
  }

  void sortTable(int columnIndex) {
    var currentValue = tableStateNotifier.value;
    var currentSortColumnIndex = currentValue['sortColumnIndex'];
    var currentSortOrder = currentValue['sortOrder'];

    var newSortOrder = SortOrder.ascending;
    if (currentSortColumnIndex == columnIndex) {
      newSortOrder = currentSortOrder == SortOrder.ascending
          ? SortOrder.descending
          : SortOrder.ascending;
    } else {
      // Se o índice da coluna for diferente, definimos a ordem de classificação como ascendente
      newSortOrder = SortOrder.ascending;
    }

    var sortedDataObjects = List.from(currentValue['dataObjects']);
    sortedDataObjects.sort((a, b) {
      var aValue = a[currentValue['propertyNames'][columnIndex]];
      var bValue = b[currentValue['propertyNames'][columnIndex]];

      if (aValue is String && bValue is String) {
        return newSortOrder == SortOrder.ascending
            ? aValue.compareTo(bValue)
            : bValue.compareTo(aValue);
      }

      if (aValue is num && bValue is num) {
        return newSortOrder == SortOrder.ascending
            ? aValue.compareTo(bValue)
            : bValue.compareTo(aValue);
      }

      return 0;
    });

    tableStateNotifier.value = {
      'status': currentValue['status'],
      'dataObjects': sortedDataObjects,
      'propertyNames': currentValue['propertyNames'],
      'columnNames': currentValue['columnNames'],
      'sortColumnIndex': columnIndex,
      'sortOrder': newSortOrder,
    };
  }
}

final dataService = DataService();

void main() {
  MyApp app = MyApp();

  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Dicas'),
          ),
          body: ValueListenableBuilder(
              valueListenable: dataService.tableStateNotifier,
              builder: (_, value, __) {
                switch (value['status']) {
                  case TableStatus.idle:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('imagens/welcome_image.png', // Caminho da imagem
                            width: 200,
                            height: 200),
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            "Seja bem vindo ao aplicativo do amor!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            "Ao apertar nos botões abaixo, você obtém informações\n diretamente de uma api da internet.",
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

                  case TableStatus.loading:
                    return Center(child: CircularProgressIndicator());

                  case TableStatus.ready:
                    return DataTableWidget(
                      jsonObjects: value['dataObjects'],
                      propertyNames: value['propertyNames'],
                      columnNames: value['columnNames'],
                      onSort: (index) => dataService.sortTable(index),
                    );

                  case TableStatus.error:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.warning_amber_outlined,
                              size: 100, color: Colors.red),
                          Text(
                            "De novo sem net na UFRN? Triste.",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Verifique sua conexão e tente novamente",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                }

                return Text("...");
              }),
          bottomNavigationBar:
              NewNavBar(itemSelectedCallback: dataService.carregar),
        ));
  }
}

class NewNavBar extends HookWidget {
  final _itemSelectedCallback;

  NewNavBar({itemSelectedCallback})
      : _itemSelectedCallback = itemSelectedCallback ?? (int);

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          state.value = index;

          _itemSelectedCallback(index);
        },
        currentIndex: state.value,
        items: const [
          BottomNavigationBarItem(
            label: "Cafés",
            icon: Icon(Icons.coffee_outlined),
          ),
          BottomNavigationBarItem(
              label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
          BottomNavigationBarItem(
              label: "Nações", icon: Icon(Icons.flag_outlined)),
          BottomNavigationBarItem(
              label: "Sangue", icon: Icon(Icons.bloodtype_outlined))
        ]);
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;
  final Function(int) onSort;
  final int initialSortColumnIndex;

  int sortColumnIndex = 0;

  DataTableWidget({
    this.jsonObjects = const [],
    this.columnNames = const [],
    this.propertyNames = const ["name", "age", "gender"],
    required this.onSort,
    this.initialSortColumnIndex = -1,
  }) : sortColumnIndex = initialSortColumnIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: _buildColumns(columnNames),
        rows: _buildRows(jsonObjects, propertyNames),
      ),
    );
  }

  List<DataColumn> _buildColumns(List<String> columnNames) {
    return columnNames
        .asMap()
        .entries
        .map((entry) => DataColumn(
              label: Text(entry.value),
              onSort: onSort != null
                  ? (index, ascending) {
                      if (sortColumnIndex != index) {
                        sortColumnIndex = index;
                      }
                      onSort(entry.key);
                    }
                  : null,
              numeric: entry.key == sortColumnIndex,
              // Adicione a propriedade "numeric" para destacar a coluna atualmente ordenada
            ))
        .toList();
  }

  List<DataRow> _buildRows(List jsonObjects, List<String> propertyNames) {
    return jsonObjects.map((jsonObject) {
      return DataRow(
        cells: propertyNames
            .map((propertyName) =>
                DataCell(Text(jsonObject[propertyName].toString())))
            .toList(),
      );
    }).toList();
  }
}