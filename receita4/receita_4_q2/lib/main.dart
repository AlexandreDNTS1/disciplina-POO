import 'package:flutter/material.dart';

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
  {"name": "Hoegaarden Original White Ale", "style": "Belgian Witbier","ibu": "15"},
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
          body: MyTileWidget(
            data: dataObjects,
            columns: ["name", "style", "ibu"],
          ),
          bottomNavigationBar: NewNavBar(),
        ));
  }
}

class DataBodyWidget extends StatelessWidget {
  List objects;

  DataBodyWidget({this.objects = const []});

  @override
  Widget build(BuildContext context) {
    var columnNames = ["Nome", "Estilo", "IBU"],
        propertyNames = ["name", "style", "ibu"];

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: columnNames
              .map((name) => DataColumn(
                  label: Expanded(
                      child: Text(name,
                          style: TextStyle(fontStyle: FontStyle.italic)))))
              .toList(),
          rows: objects
              .map((obj) => DataRow(
                  cells: propertyNames
                      .map((propName) => DataCell(Text(obj[propName])))
                      .toList()))
              .toList(),
        ),
      ),
    );
  }
}

class MyTileWidget extends StatelessWidget {
  final List data;
  final List<String> columns;

  MyTileWidget({required this.data, required this.columns});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.local_drink),
          title: Text(data[index][columns[0]]),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Estilo: ${data[index][columns[1]]}"),
              Text("IBU: ${data[index][columns[2]]}"),
            ],
          ),
        );
      },
    );
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