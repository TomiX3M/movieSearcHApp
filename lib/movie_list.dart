import 'package:flutter/material.dart';
import 'package:movie_app/http_helper.dart';
import 'package:movie_app/movieDetail.dart';

class MoviesList extends StatefulWidget {
  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('Movies');
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  HttpHelper helper = HttpHelper();
  int moviesCount = 0;
  List moviesList = [];
  late NetworkImage image;

  Future initialize() async {
    moviesList = await helper.getUpcoming();
    setState(() {
      moviesCount = moviesList.length;
      moviesList = moviesList;
    });
  }

  Future search(text) async {
    moviesList = await helper.findMovies(text);
    setState(() {
      moviesCount = moviesList.length;
      moviesList = moviesList;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: [
          IconButton(
              icon: visibleIcon,
              onPressed: () {
                setState(() {
                  if (this.visibleIcon.icon == Icons.search) {
                    this.visibleIcon = Icon(Icons.cancel);
                    this.searchBar = TextField(
                      onChanged: (e) {
                        setState(() {
                          search(e);
                        });
                      },
                      textInputAction: TextInputAction.search,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    );
                  } else {
                    setState(() {
                      this.visibleIcon = Icon(Icons.search);
                      this.searchBar = Text('Movies');
                    });
                  }
                });
              }),
        ],
      ),
      body: ListView.builder(
          itemCount: (moviesCount == 0) ? 0 : moviesCount,
          itemBuilder: (BuildContext context, int position) {
            if (moviesList[position].posterPath != null) {
              image = NetworkImage(iconBase + moviesList[position].posterPath);
            } else {
              image = NetworkImage(defaultImage);
            }
            return Card(
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: image,
                  radius: 30,
                ),
                title: Text(moviesList[position].title),
                subtitle: Text('Released: ' +
                    moviesList[position].releaseDate +
                    ' - Vote: ' +
                    moviesList[position].voteAverage.toString()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MovieDetail(moviesList[position])));
                },
              ),
            );
          }),
    );
  }
}
