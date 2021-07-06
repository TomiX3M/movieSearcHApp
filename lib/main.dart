import 'package:flutter/material.dart';
import './movie_list.dart';

void main() {
  runApp(MyMovies());
}

// ignore: must_be_immutable
class MyMovies extends StatelessWidget {
  String appKey = '2bf32619cabd99cdbae1f5b70605724f';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Movies',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MoviesList();
  }
}
