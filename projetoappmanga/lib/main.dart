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
      home: MyHomePage(title: 'API Jikan Demo'),
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

  Future<List<dynamic>> fetchManga(String query) async {
    final response = await http.get(Uri.parse('https://api.jikan.moe/v4/manga?q=$query'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load manga');
    }
  }

  void searchManga() {
    String query = searchController.text;
    setState(() {
      isSearchActive = query.isNotEmpty;
      if (isSearchActive) {
        mangaList = fetchManga(query);
      } else {
        mangaList = fetchManga('');
      }
    });
  }

  void toggleImageSize() {
    setState(() {
      imageSize = imageSize == 120.0 ? 240.0 : 120.0;
    });
  }

  void toggleSearch() {
    setState(() {
      _showSearch = !_showSearch;
      if (!_showSearch) {
        searchController.clear();
        isSearchActive = false;
        mangaList = fetchManga('');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    mangaList = fetchManga('');
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (!isSearchActive &&
        _scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      loadMoreData();
    }
  }

  Future<void> loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      // Fetch more manga data
      List<dynamic> moreMangaList = await fetchManga('');

      setState(() {
        allMangaList.addAll(moreMangaList);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          AnimatedOpacity(
            opacity: _showSearch ? 1.0 : 0.0,
            duration: Duration(milliseconds: 200),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Pesquisar mangá',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: searchManga,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<List<dynamic>>(
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
                          final imageUrl = manga['images']['jpg']['image_url'];

                          return Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: toggleImageSize,
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.fill,
                                    width: 160,
                                    height: 240,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(manga['title']),
                                  subtitle: Text('ID: ${manga['mal_id']}'),
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
                        final imageUrl = manga['images']['jpg']['image_url'];

                        return Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: toggleImageSize,
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.fill,
                                    width: 160,
                                    height: 200,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(manga['title']),
                                  subtitle: Text('ID: ${manga['mal_id']}'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: toggleSearch,
        child: Icon(_showSearch ? Icons.close : Icons.search),
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
