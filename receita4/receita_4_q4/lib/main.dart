import 'package:flutter/material.dart';

var coffeeData = [
  {'name': 'Café do Brasil', 'origin': 'Brasil', 'notes': 'Caramelo, nozes'},
  {'name': 'Café da Etiópia', 'origin': 'Etiópia', 'notes': 'Floral, frutado'},
  {
    'name': 'Café do Vietnã',
    'origin': 'Vietnã',
    'notes': 'Chocolate, especiarias'
  },
];

var dataObjects = [
  {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
  {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
  {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
  {"name": "Stella Artois", "style": "Pilsner", "ibu": "30"},
  {"name": "Guinness Draught", "style": "Stout", "ibu": "45"},
  {"name": "Heineken", "style": "Pilsner", "ibu": "23"},
  {"name": "Corona Extra", "style": "Lager", "ibu": "19"},
  {"name": "Samuel Adams Boston Lager", "style": "Lager", "ibu": "30"},
  {"name": "Newcastle Brown Ale", "style": "Brown Ale", "ibu": "20"},
  {"name": "Bud Light", "style": "Lager", "ibu": "12"},
  {"name": "Blue Moon Belgian White", "style": "Belgian Witbier", "ibu": "9"},
  {"name": "Sierra Nevada Pale Ale", "style": "Pale Ale", "ibu": "38"},
  {"name": "Chimay Blue", "style": "Belgian Strong Dark Ale", "ibu": "30"},
  {"name": "Modelo Especial", "style": "Pilsner", "ibu": "18"},
  {"name": "Paulaner Hefe-Weizen", "style": "Hefeweizen", "ibu": "12"},
  {"name": "Anchor Steam Beer", "style": "California Common", "ibu": "38"},
  {"name": "Franziskaner Hefe-Weisse", "style": "Hefeweizen", "ibu": "14"},
  {"name": "Smithwick's Irish Ale", "style": "Red Ale", "ibu": "23"},
  {"name": "Leffe Blonde", "style": "Belgian Blonde Ale", "ibu": "20"},
  {"name": "Grolsch Premium Lager", "style": "Lager", "ibu": "20"},
  {
    "name": "Hoegaarden Original White Ale",
    "style": "Belgian Witbier",
    "ibu": "15"
  },
  {"name": "Boddingtons Pub Ale", "style": "English Pale Ale", "ibu": "20"},
  {"name": "Dos Equis Lager Especial", "style": "Lager", "ibu": "23"},
  {"name": "Warsteiner Premium Verum", "style": "Pilsner", "ibu": "23"},
  {"name": "Tsingtao Beer", "style": "Lager", "ibu": "18"},
  {"name": "Bitburger Premium Pils", "style": "Pilsner", "ibu": "25"},
  {"name": "Erdinger Weissbier", "style": "Hefeweizen", "ibu": "14"},
  {"name": "Fuller's London Pride", "style": "English Pale Ale", "ibu": "30"},
  {"name": "Harp Lager", "style": "Lager", "ibu": "28"}
];

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
            title: const Text("Dicas"),
          ),
          /*
          body: DataBodyWidget(
            objects: coffeeData,
            columns: ['name', 'origin', 'notes'],
            columnLabels: ['Nome', 'Origem', 'Notas'],
          ),
          */
          body: MyListViewWidget(
            objects: coffeeData,
            columns: ['name', 'origin', 'notes'],
            propertyMap: {'name': "Nome", 'origin': 'Origem', 'notes': 'Notas'},
          ),
          bottomNavigationBar: NewNavBar(),
        ));
  }
}

class NewNavBar extends StatelessWidget {
  NewNavBar();

  void botaoFoiTocado(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(onTap: botaoFoiTocado, items: const [
      BottomNavigationBarItem(
        label: "Cafés",
        icon: Icon(Icons.coffee_outlined),
      ),
      BottomNavigationBarItem(
          label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
      BottomNavigationBarItem(label: "Nações", icon: Icon(Icons.flag_outlined))
    ]);
  }
}

class DataBodyWidget extends StatelessWidget {
  final List objects;
  final List<String> columns;
  final Map<String, String> propertyMap;
  final List<String> columnLabels;

  DataBodyWidget({
    required this.objects,
    required this.columns,
    this.propertyMap = const {},
    this.columnLabels = const [],
  });

  @override
  Widget build(BuildContext context) {
    final List<String> columnNames =
        columnLabels.isNotEmpty ? columnLabels : columns;
    final List<DataColumn> dataColumns = columnNames.map(
      (name) {
        return DataColumn(
          label: Expanded(
            child: Text(
              name,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        );
      },
    ).toList();

    final List<DataRow> dataRows = objects.map(
      (obj) {
        return DataRow(
          cells: columns.map(
            (propName) {
              final label = propertyMap[propName] ?? propName;
              final value = obj[propName]?.toString() ?? '';
              return DataCell(Text(value),
                  placeholder: false, showEditIcon: false);
            },
          ).toList(),
        );
      },
    ).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: dataColumns,
          rows: dataRows,
        ),
      ),
    );
  }
}

class MyTileWidget extends StatelessWidget {
  final List objects;
  final List<String> columns;
  final Map<String, String> propertyMap;
  final List<String> columnLabels;

  MyTileWidget({
    required this.objects,
    required this.columns,
    this.propertyMap = const {},
    this.columnLabels = const [],
  });

  @override
  Widget build(BuildContext context) {
    final List<String> columnNames =
        columnLabels.isNotEmpty ? columnLabels : columns;

    return ListView.builder(
      itemCount: objects.length,
      itemBuilder: (BuildContext context, int index) {
        final obj = objects[index];
        final tiles = columns.map(
          (propName) {
            final label = propertyMap[propName] ?? propName;
            final value = obj[propName]?.toString() ?? '';
            return ListTile(
              leading: Icon(Icons.local_drink),
              title: Text(label),
              subtitle: Text(value),
            );
          },
        ).toList();

        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tiles,
          ),
        );
      },
    );
  }
}

class MyListViewWidget extends StatelessWidget {
  final List objects;
  final List<String> columns;
  final Map<String, String> propertyMap;
  final List<String> columnLabels;

  MyListViewWidget({
    required this.objects,
    required this.columns,
    this.propertyMap = const {},
    this.columnLabels = const [],
  });

  @override
  Widget build(BuildContext context) {
    final List<String> columnNames =
        columnLabels.isNotEmpty ? columnLabels : columns;

    return ListView.builder(
      itemCount: objects.length,
      itemBuilder: (BuildContext context, int index) {
        final obj = objects[index];
        final tiles = columns.map(
          (propName) {
            final label = propertyMap[propName] ?? propName;
            final value = obj[propName]?.toString() ?? '';
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(value),
                ],
              ),
            );
          },
        ).toList();

        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tiles,
          ),
        );
      },
    );
  }
}