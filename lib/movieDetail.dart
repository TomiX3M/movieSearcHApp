import 'package:flutter/material.dart';
import 'movie.dart';

class MovieDetail extends StatelessWidget {
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';
  final Movie movie;
  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    String path;
    // ignore: unnecessary_null_comparison
    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          children: <Widget>[
            Container(
              child: Image.network(
                path,
              ),
              height: height / 1.5,
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(movie.overview),
            )
          ],
        ))));
  }
}
