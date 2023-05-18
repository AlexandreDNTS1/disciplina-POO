import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text("Cervejas")),
        body: SingleChildScrollView(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text("Nome")),
              DataColumn(label: Text("Estilo")),
              DataColumn(label: Text("IBU")),
            ],
            rows: <DataRow>[
              DataRow(cells: <DataCell>[
                DataCell(Text("La Fin Du Monde")),
                DataCell(Text("Bock")),
                DataCell(Text("65")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Sapporo Premium")),
                DataCell(Text("Sour Ale")),
                DataCell(Text("54")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Duvel")),
                DataCell(Text("Pilsner")),
                DataCell(Text("82")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Guinness Draught")),
                DataCell(Text("Stout")),
                DataCell(Text("45")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Heineken")),
                DataCell(Text("Pale Lager")),
                DataCell(Text("23")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Chimay Blue")),
                DataCell(Text("Belgian Strong Dark Ale")),
                DataCell(Text("75")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Budweiser")),
                DataCell(Text("American Lager")),
                DataCell(Text("12")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Coors Light")),
                DataCell(Text("Light Lager")),
                DataCell(Text("8")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Corona")),
                DataCell(Text("Pale Lager")),
                DataCell(Text("18")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Stella Artois")),
                DataCell(Text("Pale Lager")),
                DataCell(Text("30")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Pilsner Urquell")),
                DataCell(Text("Pilsner")),
                DataCell(Text("40")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Paulaner Hefe-Weissbier")),
                DataCell(Text("Hefeweizen")),
                DataCell(Text("14")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Hoegaarden")),
                DataCell(Text("Witbier")),
                DataCell(Text("16")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Belhaven Scottish Ale")),
                DataCell(Text("Scottish Ale")),
                DataCell(Text("55")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Sierra Nevada Pale Ale")),
                DataCell(Text("American Pale Ale")),
                DataCell(Text("42")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Founders All Day IPA")),
                DataCell(Text("Session IPA")),
                DataCell(Text("35")),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text("Brouwerij 't IJ IPA")),
                DataCell(Text("IPA")),
                DataCell(Text("60")),
              ]),
              // Adicione mais linhas aqui
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Ação do botão 1
                  },
                  child: Icon(Icons.home),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Ação do botão 2
                  },
                  child: Icon(Icons.search),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Ação do botão 3
                  },
                  child: Icon(Icons.person),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
