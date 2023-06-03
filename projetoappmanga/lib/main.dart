import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SEU MANGA FAVORITO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(), // Altera a tela inicial para a tela de boas-vindas
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SEU MANGA FAVORITO'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo ao SEU MANGA FAVORITO!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Começar'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyHomePage(title: 'SEU MANGA FAVORITO'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<dynamic>> mangaList;
  List<dynamic> allMangaList = [];
  TextEditingController searchController = TextEditingController();
  double imageSize = 120.0;
  bool _showSearch = false;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();
  bool isSearchActive = false;
  int currentIndex = 0;
  bool showAboutScreen = false; // Novo estado para exibir o texto "teste app"

  Future<List<dynamic>> fetchManga(String query, [int? page]) async {
    final url = page != null
        ? 'https://api.jikan.moe/v4/manga?q=$query&page=$page'
        : 'https://api.jikan.moe/v4/manga?q=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load manga');
    }
  }

  void exibirPesquisa() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        showAboutScreen = false;
        return AlertDialog(
          title: Text('Pesquisar manga'),
          content: TextField(
            controller: searchController,
          ),
          actions: [
            TextButton(
              child: Text('Pesquisar'),
              onPressed: () {
                searchManga();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void redirectToMangaScreen() {
    setState(() {
      showAboutScreen =
          false; // Altera o estado para não exibir o texto "teste app"
      currentIndex = 0; // Define o índice atual como 0 (Home)
      mangaList = fetchManga(''); // Carrega os mangás novamente
    });
  }

  void sobreApp() {
    setState(() {
      showAboutScreen = true;
    });
  }

  void searchManga() {
    String query = searchController.text;
    showAboutScreen = false;
    setState(() {
      isSearchActive = query.isNotEmpty;
      if (isSearchActive) {
        mangaList = fetchManga(query);
      } else {
        mangaList = fetchManga('');
      }
    });
  }

  void toggleSearch() {
    redirectToMangaScreen();
  }

  @override
  void initState() {
    super.initState();
    mangaList = fetchManga('');
    _scrollController.addListener(_scrollListener);
    currentIndex = 0; // Inicialmente, o botão "Home" estará pressionado
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (!isSearchActive &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      loadMoreData();
    }
  }

  Future<void> loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      // Fetch more manga data
      List<dynamic> moreMangaList =
          await fetchManga('', allMangaList.length ~/ 20 + 1);

      setState(() {
        allMangaList.addAll(moreMangaList);
        isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: showAboutScreen
                  ? AboutScreen() // Adicione um novo widget chamado AboutScreen para exibir a tela "Sobre o App"
                  : FutureBuilder<List<dynamic>>(
                      future: mangaList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && !isSearchActive) {
                          allMangaList = snapshot.data!;
                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: allMangaList.length + 1,
                            itemBuilder: (context, index) {
                              if (index < allMangaList.length) {
                                final manga = allMangaList[index];
                                final imageUrl =
                                    manga['images']['jpg']['large_image_url'];
                                final authors =
                                    manga['authors'] as List<dynamic>;
                                final genres = 
                                    manga['genres'] as List<dynamic>;
                                return Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.fill,
                                          width: 360,
                                          height: 440,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text(manga['title']),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('ID: ${manga['mal_id']}'),
                                            Text(
                                              'AUTOR/AUTORES:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: authors.map((author) {
                                                return Text(author['name']);
                                              }).toList(),
                                            ),
                                            Text(
                                                'CAPÍTULOS: ${manga['chapters']}'),
                                            Text(
                                                'VOLUMES: ${manga['volumes']}'),
                                            Text(
                                              'GENERO: ${genres.map((genre) => genre['name']).join(", ")}'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (isLoading) {
                                return _buildLoader();
                              } else {
                                return SizedBox();
                              }
                            },
                          );
                        } else if (snapshot.hasData && isSearchActive) {
                          List<dynamic> searchResults = snapshot.data!;
                          return ListView.builder(
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              final manga = searchResults[index];
                              final imageUrl =
                                  manga['images']['jpg']['large_image_url'];
                              final authors =
                                    manga['authors'] as List<dynamic>;
                              final genres = 
                                    manga['genres'] as List<dynamic>;
                              return Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.fill,
                                        width: 360,
                                        height: 440,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                        title: Text(manga['title']),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('ID: ${manga['mal_id']}'),
                                            Text(
                                              'AUTOR/AUTORES:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: authors.map((author) {
                                                return Text(author['name']);
                                              }).toList(),
                                            ),
                                            Text(
                                                'CAPÍTULOS: ${manga['chapters']}'),
                                            Text(
                                                'VOLUMES: ${manga['volumes']}'),
                                            Text(
                                              'GENERO: ${genres.map((genre) => genre['name']).join(", ")}'),
                                          ],
                                        ),
                                      ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        return CircularProgressIndicator();
                      },
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pesquisar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Sobre',
          ),
        ],
        currentIndex: currentIndex, // Define o índice atual
        onTap: (int index) {
          if (index == 0) {
            toggleSearch();
          }
          if (index == 1) {
            exibirPesquisa();
          } else if (index == 2) {
            sobreApp();
          } else {
            // Handle other tab taps
          }
          setState(() {
            currentIndex = index; // Atualiza o índice atual
          });
        },
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'SEU MANGA FAVORITO',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Nesse app, o usuário poderá buscar pelo seu mangá favorito.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Recursos do aplicativo:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '- Pesquisa de mangás',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            '- Visualização de detalhes do mangá',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            '- Carregamento progressivo de resultados',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
