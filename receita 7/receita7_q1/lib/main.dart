import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert';



class DataService {
  final ValueNotifier<List> tableStateNotifier = new ValueNotifier([]);
    static List<String> columnNames = [];
  static List<String> propertyNames = [];

  void carregar(index) {
    var res = null;

    print('carregar #1 - antes de carregarDados');

    if (index == 0) res = carregarDados('coffee');

    else if (index == 1) res = carregarDados('beer');

    else if (index == 2) res = carregarDados('nation');

    print('carregar #2 - carregarDados retornou $res');
  }

  Future<void> carregarDados(String dataType) async {
    var uri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/$dataType/random_$dataType',
      queryParameters: {'size': '5'},
    );

    try {
      var response = await http.get(uri);
      var jsonData = jsonDecode(response.body);
      tableStateNotifier.value = List<Map<String, dynamic>>.from(jsonData);
    } catch (e) {
      print('Erro ao carregar $dataType: $e');
    }
    if (dataType == 'beer')
      DataService.columnNames = [
      "ID",
      "UID",
      "brand",
      "Nome",
      "Estilo",
      "hop",
      "Fermentada",
      "Malte",
      "ibu",
      "alcohol",
      "blg"
    ];
    DataService.propertyNames = [
      "id",
      "uid",
      "brand",
      "name",
      "style",
      "hop",
      "yeast",
      "malts",
      "ibu",
      "alcohol",
      "blg"
    ];
  if (dataType == 'coffee'){
    DataService.columnNames = [
      "ID",
      "UID",
      "Blend",
      "Origem",
      "Variedade",
      "Notas",
      "Intensidade"
    ];
    DataService.propertyNames = [
      "id",
      "uid",
      "blend_name",
      "origin",
      "variety",
      "notes",
      "intensifier"
    ];

  }
  else if (dataType == 'nation'){
        DataService.columnNames = [
      "ID",
      "UID",
      "Nacionalidade",
      "Idioma",
      "Capital",
      "Esporte nacional",
      "Bandeira"
    ];
    DataService.propertyNames = [
      "id",
      "uid",
      "nationality",
      "language",
      "capital",
      "national_sport",
      "flag"
    ];
  }
  }
  }


final dataService = DataService();

void main() {
  dataService.carregar(0); // Carregar dados de café
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
        body: ValueListenableBuilder<List>(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            return DataTableWidget(
              jsonObjects: value,
                      propertyNames: DataService.propertyNames,
                        columnNames: DataService.columnNames
            );
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

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataTableWidget({
    this.jsonObjects = const [],
    required this.columnNames,
    required this.propertyNames,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columnNames.map((name) {
        return DataColumn(
          label: Expanded(
            child: Text(
              name,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        );
      }).toList(),
      rows: jsonObjects.map((obj) {
        return DataRow(
          cells: propertyNames.map((propName) {
            return DataCell(Text(obj[propName].toString()));
          }).toList(),
        );
      }).toList(),
    );
  }
}
