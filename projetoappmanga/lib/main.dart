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
      title: 'API Jikan Demo',
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
  TextEditingController searchController = TextEditingController();
  double imageSize = 120.0;

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
      mangaList = fetchManga(query);
    });
  }

  void toggleImageSize() {
    setState(() {
      imageSize = imageSize == 120.0 ? 240.0 : 120.0;
    });
  }

  @override
  void initState() {
    super.initState();
    mangaList = fetchManga('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
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
          Expanded(
            child: Center(
              child: FutureBuilder<List<dynamic>>(
                future: mangaList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final manga = snapshot.data![index];
                        final imageUrl = manga['images']['jpg']['image_url'];

                        return Container(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: toggleImageSize,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.contain,
                                width: imageSize,
                                height: imageSize,
                              ),
                            ),
                            title: Text(manga['title']),
                            subtitle: Text('ID: ${manga['mal_id']}'),
                          ),
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
    );
  }
}
