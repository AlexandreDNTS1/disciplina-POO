import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class DataService {
  static final ValueNotifier<List> tableStateNotifier = ValueNotifier([]);

  static List<String> cafeColumnNames = [
    "ID",
    "UID",
    "Blend",
    "Origem",
    "Variedade",
    "Notas",
    "Intensidade"
  ];
  static List<String> cafePropertyNames = [
    "id",
    "uid",
    "blend_name",
    "origin",
    "variety",
    "notes",
    "intensifier"
  ];

  static List<String> cervejaColumnNames = [
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
  static List<String> cervejaPropertyNames = [
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

  static List<String> nacaoColumnNames = [
    "ID",
    "UID",
    "Nacionalidade",
    "Idioma",
    "Capital",
    "Esporte nacional",
    "Bandeira"
  ];
  static List<String> nacaoPropertyNames = [
    "id",
    "uid",
    "nationality",
    "idioma",
    "capital",
    "esporte_nacional",
    "bandeira"
  ];

  final List<Function> _carregarFunctions = [
    carregarCafes,
    carregarCervejas,
    carregarNacoes,
  ];

  static List<String> columnNames = ["Nome", "Estilo", "IBU"];
  static List<String> propertyNames = ["name", "style", "ibu"];

  void carregar(index) {
    _carregarFunctions[index]();
  }

  static void carregarCervejas() {
    tableStateNotifier.value = [
      {
        "id": "163",
        "uid": "978eee96-72f4-42b6-a221-bfe1c7376877",
        "brand": "Becks",
        "name": "Arrogant Bastard Ale",
        "style": "Strong Ale",
        "hop": "Horizon",
        "yeast": "3333 - German Wheat",
        "malts": "Munich",
        "ibu": "72 IBU",
        "alcohol": "8.5%",
        "blg": "13.3°Blg"
      },
      {
        "id": "8766",
        "uid": "1732b5a9-211c-4789-8ccb-32fbc49c2bab",
        "brand": "Kirin",
        "name": "Hennepin",
        "style": "Wood-aged Beer",
        "hop": "Simcoe",
        "yeast": "1187 - Ringwood Ale",
        "malts": "Pale",
        "ibu": "39 IBU",
        "alcohol": "8.3%",
        "blg": "5.8°Blg"
      },
      {
        "id": "2969",
        "uid": "12629ef8-c863-481f-b8b0-eedb543cb38d",
        "brand": "Patagonia",
        "name": "Westmalle Trappist Tripel",
        "style": "European Amber Lager",
        "hop": "Sterling",
        "yeast": "2206 - Bavarian Lager",
        "malts": "Vienna",
        "ibu": "31 IBU",
        "alcohol": "3.5%",
        "blg": "9.8°Blg"
      },
      {
        "id": "3559",
        "uid": "6e86dc3e-e09b-4fdf-942d-66580c046e5f",
        "brand": "Coors lite",
        "name": "Alpha King Pale Ale",
        "style": "Strong Ale",
        "hop": "Equinox",
        "yeast": "5733 - Pediococcus",
        "malts": "Munich",
        "ibu": "55 IBU",
        "alcohol": "3.8%",
        "blg": "12.8°Blg"
      },
      {
        "id": "6799",
        "uid": "1655b5bc-2b96-470b-a319-00e564fc827f",
        "brand": "Quimes",
        "name": "Delirium Noctorum",
        "style": "Bock",
        "hop": "Tettnang",
        "yeast": "2124 - Bohemian Lager",
        "malts": "Vienna",
        "ibu": "50 IBU",
        "alcohol": "2.3%",
        "blg": "14.7°Blg"
      }
    ];
    DataService.columnNames = DataService.cervejaColumnNames;
    DataService.propertyNames = DataService.cervejaPropertyNames;
  }

  static void carregarCafes() {
    tableStateNotifier.value = tableStateNotifier.value = [
      {
        "id": "9891",
        "uid": "ed2109df-6a1b-439e-9f9c-0e9fd3ca3abb",
        "blend_name": "Dark Town",
        "origin": "Ilha do Café Gishamwana, Ruanda",
        "variety": "Dilla",
        "notes": "brilhante, com sabor de chá, borracha, tâmara, lúpulo",
        "intensifier": "sem graça"
      },
      {
        "id": "4871",
        "uid": "fe96994a-4a3c-4fab-a1ed-f43a77e3eadf",
        "blend_name": "Olhar de Ação de Graças",
        "origin": "Mattari, Iêmen",
        "variety": "S288",
        "notes": "denso, sedoso, xarope de bordo, uva concord, carambola",
        "intensifier": "vibrante"
      },
      {
        "id": "6863",
        "uid": "d448b0e9-66e9-433a-8a18-49a373ae7555",
        "blend_name": "Copo de Especiarias de Abóbora",
        "origin": "Chiriqui, Panamá",
        "variety": "Pacas",
        "notes": "crocante, intenso, canela, pão fresco, avelã",
        "intensifier": "vibrante"
      },
      {
        "id": "7704",
        "uid": "e77bf8ef-9516-44e7-9cf0-e211572a2d28",
        "blend_name": "Expresso Selecto",
        "origin": "Montecillos, Honduras",
        "variety": "Liberica",
        "notes": "azedo, suave, chocolate ao leite, pão fresco, alcaçuz",
        "intensifier": "suculento"
      },
      {
        "id": "4525",
        "uid": "742e8809-4f75-4ed2-a718-fc07cb9bc988",
        "blend_name": "Bom-dia Estrela",
        "origin": "Região de Mbeya, Tanzânia",
        "variety": "Agaro",
        "notes": "arredondado, escorregadio, melão, clementina, melaço",
        "intensifier": "seco"
      }
    ];
    DataService.columnNames = DataService.cafeColumnNames;
    DataService.propertyNames = DataService.cafePropertyNames;
  }

  static void carregarNacoes() {
    tableStateNotifier.value = [
      {
        "id": "9903",
        "uid": "ec456dea-ca19-4e05-a31e-10f1a12d7b75",
        "nationality": "Arubanos",
        "idioma": "Português",
        "capital": "Mogadíscio",
        "esporte_nacional": "rúgbi",
        "bandeira": "🇸🇾"
      },
      {
        "id": "2549",
        "uid": "9e197c3b-824e-4217-bf33-f57287fe4131",
        "nationality": "Espanhóis",
        "idioma": "Javanês",
        "capital": "Damasco",
        "esporte_nacional": "luta",
        "bandeira": "🇧🇫"
      },
      {
        "id": "3582",
        "uid": "70c86b5a-bb50-4de7-95b0-44e8bac18e64",
        "nationality": "Ingleses",
        "idioma": "Italiano",
        "capital": "Podgorica",
        "esporte_nacional": "vôlei",
        "bandeira": "🇧🇸"
      },
      {
        "id": "2771",
        "uid": "6e1117f8-3d20-4fea-b5c4-ee49a1a7c3e7",
        "nationality": "Zimbabuanos",
        "idioma": "Coreano",
        "capital": "Majuro",
        "esporte_nacional": "lacrosse",
        "bandeira": "🇳🇮"
      },
      {
        "id": "8408",
        "uid": "c247a7bb-f833-4dca-a220-3155b51d243b",
        "nationality": "Israelitas",
        "idioma": "Coreano",
        "capital": "Tashkent",
        "esporte_nacional": "luta de óleo",
        "bandeira": "🇸🇯"
      }
    ];
    DataService.columnNames = DataService.nacaoColumnNames;
    DataService.propertyNames = DataService.nacaoPropertyNames;
  }
}

final dataService = DataService();

void main() {
  MyApp app = MyApp();
  runApp(app);

  dataService.carregar(1);
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
          body: Container(
            width: 2000, //double.infinity
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ValueListenableBuilder(
                  valueListenable: DataService.tableStateNotifier,
                  builder: (_, value, __) {
                    return DataTableWidget(
                        jsonObjects: value,
                        propertyNames: DataService.propertyNames,
                        columnNames: DataService.columnNames);
                  }),
            ),
          ),
          bottomNavigationBar:
              NewNavBar(itemSelectedCallback: dataService.carregar),
        ));
  }
}

class NewNavBar extends HookWidget {
  var itemSelectedCallback; //esse atributo será uma função

  NewNavBar({this.itemSelectedCallback}) {
    itemSelectedCallback ??= () {};
  }

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          dataService.carregar(index);
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
              label: "Nações", icon: Icon(Icons.flag_outlined))
        ]);
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataTableWidget({
    this.jsonObjects = const [],
    this.columnNames = const ["Nome", "Estilo", "IBU"],
    this.propertyNames = const ["name", "style", "ibu"],
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columnNames
          .map(
            (name) => DataColumn(
              label: Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          )
          .toList(),
      rows: jsonObjects.map(
        (obj) {
          return DataRow(
            cells: propertyNames
                .map(
                  (propName) => DataCell(
                    Text(obj[propName]),
                  ),
                )
                .toList(),
          );
        },
      ).toList(),
    );
  }
}