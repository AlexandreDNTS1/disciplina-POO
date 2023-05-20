import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

enum TableStatus{idle,loading,ready,error}

class DataService{

  
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier =
      ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'columnNames': ["Nome", "Estilo", "IBU"], // Adicionado columnNames como parte do estado
  });

  

  void carregar(index){

    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes];

    tableStateNotifier.value = {

      'status': TableStatus.loading,

      'dataObjects': []

    };

    funcoes[index]();

  }

  void carregarCafes(){

    return;

  }


  void carregarNacoes(){

    return;

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
      'columnNames': ["Nome", "Estilo", "IBU"], // Definir os nomes das colunas na tabela
    };
  });
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
          title: const Text("Dicas"),
        ),
        body: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case TableStatus.idle:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('imagens/welcome_image.png'), 
                      SizedBox(height: 16),
                      Text(
                        "Bem-vindo ao App!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Toque em um dos botões abaixo para carregar os dados.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              case TableStatus.loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case TableStatus.ready:
                return DataTableWidget(
                  jsonObjects: value['dataObjects'],
                  propertyNames: value['propertyNames'],
                  columnNames: value['columnNames'],
                );
              case TableStatus.error:
                return Text("Lascou");
            }
            return Text("...");
          },
        ),
        bottomNavigationBar: NewNavBar(itemSelectedCallback: dataService.carregar),
      ),
    );
  }
}


class NewNavBar extends HookWidget {

  final _itemSelectedCallback;

  NewNavBar({itemSelectedCallback}):

    _itemSelectedCallback = itemSelectedCallback ?? (int){}

    


  @override

  Widget build(BuildContext context) {

    var state = useState(1);

    

    return BottomNavigationBar(

      onTap: (index){

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
        (obj) => DataRow(
          cells: propertyNames
              .map(
                (propName) => DataCell(Text(obj[propName])),
              )
              .toList(),
        ),
      ).toList(),
    );
  }
}
