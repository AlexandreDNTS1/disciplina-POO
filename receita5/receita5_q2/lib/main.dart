import 'package:flutter/material.dart';

var dataObjects = [];

void main() {
  MyApp app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("no build da classe MyApp");
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dicas"),
        ),
        body: DataTableWidget(jsonObjects: dataObjects),
        bottomNavigationBar: NewNavBar2(),
      ),
    );
  }
}

class NewNavBar extends StatelessWidget {
  NewNavBar();

  @override
  Widget build(BuildContext context) {
    print("no build da classe NewNavBar");
    return BottomNavigationBar(
      onTap: (index) {},
      currentIndex: 1,
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

class NewNavBar2 extends StatefulWidget {
  NewNavBar2();

  @override
  _NewNavBar2State createState() => _NewNavBar2State();
}

class _NewNavBar2State extends State<NewNavBar2> {
  int _currentIndex = 1;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("no build da classe NewNavBar2");
    return BottomNavigationBar(
      onTap: _onTap,
      currentIndex: _currentIndex,
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

  DataTableWidget({this.jsonObjects = const []});

  @override
  Widget build(BuildContext context) {
    print("no build da classe DataTableWidget");
    var columnNames = ["Nome", "Estilo", "IBU"];
    var propertyNames = ["name", "style", "ibu"];

    return DataTable(
      columns: columnNames
          .map(
            (name) => DataColumn(
              label: Expanded(
                child: Text(name, style: TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
          )
          .toList(),
      rows: jsonObjects
          .map(
            (obj) => DataRow(
              cells: propertyNames
                  .map(
                    (propName) => DataCell(Text(obj[propName])),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}

