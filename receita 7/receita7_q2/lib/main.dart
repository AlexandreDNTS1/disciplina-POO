import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert';



class DataService {
  final ValueNotifier<List> tableStateNotifier = new ValueNotifier([]);
    static List<String> columnNames = [];
  static List<String> propertyNames = [];

void carregar(int index, int itemCount) {
  var res = null;

  print('carregar #1 - antes de carregarDados');

  if (index == 0) res = carregarDados('coffee', itemCount);
  else if (index == 1) res = carregarDados('beer', itemCount);
  else if (index == 2) res = carregarDados('nation', itemCount);

  print('carregar #2 - carregarDados retornou $res');
}

Future<void> carregarDados(String dataType, int itemCount) async {
  var uri = Uri(
    scheme: 'https',
    host: 'random-data-api.com',
    path: 'api/$dataType/random_$dataType',
    queryParameters: {'size': '$itemCount'},
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
  dataService.carregar(0,5); // Carregar dados de café
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedOption = 5; // Valor padrão para a quantidade de itens a serem carregados

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dicas"),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Quantidade de itens:"),
                SizedBox(width: 10),
                DropdownButton<int>(
                  value: selectedOption,
                  items: [
                    DropdownMenuItem<int>(
                      value: 5,
                      child: Text("5"),
                    ),
                    DropdownMenuItem<int>(
                      value: 10,
                      child: Text("10"),
                    ),
                    DropdownMenuItem<int>(
                      value: 15,
                      child: Text("15"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: ValueListenableBuilder<List>(
                valueListenable: dataService.tableStateNotifier,
                builder: (_, value, __) {
                  return DataTableWidget(
                    jsonObjects: value,
                    propertyNames: DataService.propertyNames,
                    columnNames: DataService.columnNames,
                    itemCount: selectedOption,
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: NewNavBar(itemSelectedCallback: (index) {
  dataService.carregar(index, selectedOption); // Passar o valor selecionado da caixa de seleção
}),

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
  final int itemCount;

  DataTableWidget({
    this.jsonObjects = const [],
    required this.columnNames,
    required this.propertyNames,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    final displayedItems = jsonObjects.take(itemCount).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Adiciona rolagem horizontal
      child: SingleChildScrollView(
        child: DataTable(
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
          rows: displayedItems.map((obj) {
            return DataRow(
              cells: propertyNames.map((propName) {
                return DataCell(Text(obj[propName].toString()));
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
