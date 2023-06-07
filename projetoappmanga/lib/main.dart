import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
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
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'SEU MANGA FAVORITO'),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("gifs/animeGIF.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
            ],
          ),
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
  // bool _showSearch = false;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();
  bool isSearchActive = false;
  int currentIndex = 0;
  bool showAboutScreen = false;

  Future<List<dynamic>> fetchManga(String query, [int? page]) async {
    final url = page != null
        ? 'https://api.jikan.moe/v4/manga?q=$query&page=$page&lang=pt'
        : 'https://api.jikan.moe/v4/manga?q=$query&lang=pt';
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
      showAboutScreen = false;
      currentIndex = 0;
      mangaList = fetchManga('');
    });
  }

  void favorito() {
    print('favorito');
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
    currentIndex = 0;
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
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: showAboutScreen
                  ? AboutScreen()
                  : currentIndex == 0
                      ? WelcomeScreen()
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
                                    final imageUrl = manga['images']['jpg']
                                        ['large_image_url'];
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
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: ListTile(
                                            title: Text(manga['title'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('ID: ${manga['mal_id']}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text('AUTOR/AUTORES:',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children:
                                                      authors.map((author) {
                                                    return Text(author['name'],
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold));
                                                  }).toList(),
                                                ),
                                                Text(
                                                  'CAPÍTULOS: ${manga['chapters']}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    'VOLUMES: ${manga['volumes']}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    'GÊNERO: ${genres.map((genre) => genre['name']).join(", ")}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    'PONTUAÇÃO: ${manga['score']}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text('TIPO: ${manga['type']}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    'POPULARIDADE: ${manga['popularity']}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                 Text(
                                                    'SINOPSE: ${manga['synopsis']}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                          title: Text(manga['title'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('ID: ${manga['mal_id']}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text('AUTOR/AUTORES:',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: authors.map((author) {
                                                  return Text(author['name'],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold));
                                                }).toList(),
                                              ),
                                              Text(
                                                'CAPÍTULOS: ${manga['chapters']}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  'VOLUMES: ${manga['volumes']}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  'GÊNERO: ${genres.map((genre) => genre['name']).join(", ")}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  'PONTUAÇÃO: ${manga['score']}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text('TIPO: ${manga['type']}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  'POPULARIDADE: ${manga['popularity']}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                               Text(
                                                    'SINOPSE: ${manga['synopsis']}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
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
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'manga',
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
        currentIndex: currentIndex,
        onTap: (int index) {
          if (index == 0) {
            redirectToMangaScreen(); // Redireciona para a tela inicial ("Home")
            _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else if (index == 1) {
            toggleSearch();
            _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else if (index == 2) {
            exibirPesquisa();
            _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else if (index == 3) {
            sobreApp();
            _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            // Handle other tab taps
          }
          setState(() {
            currentIndex = index;
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
          RichText(
            text: TextSpan(
              text: 'Esse app foi desenvolvido usando a API  ',
              children: [
                TextSpan(
                  text: 'Jikan API (4.0.0)',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch('https://docs.api.jikan.moe/#tag/manga');
                    },
                ),
              ],
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
            '- Carregamento progressivo de resultados\n',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'DESENVOLVEDOR',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '- Francimar Alexandre de Oliveira Dantas',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
