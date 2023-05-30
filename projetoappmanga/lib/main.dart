import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'columnNames': [],
    'propertyNames': [],
    'error': '',
  });

  void carregar(String mangaName) {
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'columnNames': [],
      'propertyNames': [],
    };

    pesquisarManga(mangaName);
  }

  void pesquisarManga(String mangaName) {
    var mangaUri = Uri.https('api.jikan.moe', '/v4/manga', {'q': mangaName});

    http.get(mangaUri).then((response) {
      if (response.statusCode == 200) {
        var mangaJson = jsonDecode(response.body);

        List<dynamic> mangaData = mangaJson['data'];
        List<dynamic> filteredData = mangaData
            .where((obj) => obj['type'] == 'Manga')
            .toList(); // Filtrar apenas os dados do tipo "Manga"

        tableStateNotifier.value = {
          'status': TableStatus.ready,
          'dataObjects': filteredData,
          'propertyNames': ["title", "type", "score", "authors", "imageUrl"],
          'columnNames': ["Título", "Tipo", "Pontuação", "Autores/Autor", "Imagem"],
        };
      } else {
        throw Exception('Falha ao pesquisar o mangá');
      }
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'error': 'Erro ao pesquisar dados do mangá.',
      };
    });
  }
}

final dataService = DataService();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("BUSCA MANGÁ"),
        ),
        body: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case TableStatus.idle:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'imagens/logo.png',
                          ),
                          Text(
                            "Seja bem-vindo ao app de busca de mangá",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextField(
                            controller: _textFieldController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Digite o nome do mangá',
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              String mangaName = _textFieldController.text;
                              if (mangaName.isNotEmpty) {
                                dataService.carregar(mangaName);
                              }
                            },
                            child: Text('Buscar'),
                          ),
                        ],
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
                final dataObjects = value['dataObjects'];
                if (dataObjects.isNotEmpty) {
                  return SingleChildScrollView(
                    child: DataTableWidget(
                      jsonObjects: dataObjects,
                      columnNames: value['columnNames'],
                      propertyNames: value['propertyNames'],
                    ),
                  );
                } else {
                  return SobreWidget();
                }
              default:
                return Text("...");
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
          backgroundColor: Colors.blue,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
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
      columns: columnNames
          .map(
            (name) => DataColumn(
              label: Text(
                name,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          )
          .toList(),
      rows: jsonObjects
          .map(
            (obj) => DataRow(
              cells: propertyNames.map(
                (propName) {
                  if (propName == "authors") {
                    final authorsList = obj[propName] as List<dynamic>?;
                    final authorNames = authorsList != null
                        ? authorsList
                            .map((author) => author['name'].toString())
                            .join(', ')
                        : '';
                    return DataCell(
                      Text(authorNames),
                    );
                  } else if (propName == "image") {
                    
                    String imageUrl = obj[propName]['image_url'].toString();
                    print(imageUrl);
                    return DataCell(
                      imageUrl.isNotEmpty
                          ? Image.network(imageUrl)
                          : Text('-'),
                    );
                  } else {
                    final propValue = obj[propName];
                    return DataCell(
                      propValue != null ? Text(propValue.toString()) : Text('-'),
                    );
                  }
                },
              ).toList(),
            ),
          )
          .toList(),
    );
  }
}

class SobreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        SizedBox(height: 16),
        Center(
          child: Text(
            "Seja bem-vindo ao app de busca de mangá\n\nNesse aplicativo, você poderá buscar seu mangá favorito e adicioná-lo aos favoritos.",
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
  }
}
