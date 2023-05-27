import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Manga'),
        ),
        body: Center(
          child: Text('seja bem-vindo ao app de busca de  manga'),
        ),
      ),
    );
  }
}



