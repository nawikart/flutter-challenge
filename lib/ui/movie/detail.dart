import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../components/primaryButton.dart';
import '../components/leftBamper.dart';
import '../components/loadingPage.dart';
import '../../api/movie.dart';
import '../../model/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  final String id;
  MovieDetailScreen(this.id);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool loading = false;
  Future<MovieModel> movie;

  @override
  void initState() {
    super.initState();
    movie = MovieApi().getDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.blue,
          body: SingleChildScrollView(
            child: FutureBuilder<MovieModel>(
              future: movie,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return new LoadingPage();
                  default:
                    if (snapshot.hasError)
                      return Center(
                          child: new Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      ));
                    else if (snapshot.data == null)
                      return Center(
                        child: Text('Not Found',
                            style: TextStyle(color: Colors.red)),
                      );
                    else
                      return _item(snapshot.data);
                }
              },
            ),
          ),
        ),
        LeftBamper()
      ],
    );
  }

  Widget _item(MovieModel movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 40, 20, 20),
            child: Text(
              movie.title,
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
          Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: movie.poster_path,
                placeholder: (context, url) => Container(
                    height: 200,
                    width: 200,
                    alignment: Alignment(0, 0),
                    child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                margin: EdgeInsets.only(top: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      margin: EdgeInsets.only(top: 5),
                      color: Colors.black38,
                      child: Text(
                        'Popularity: ${movie.popularity}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      margin: EdgeInsets.only(top: 5),
                      color: Colors.black38,
                      child: Text(
                        'Release date: ${movie.release_date}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      margin: EdgeInsets.only(top: 5),
                      color: Colors.black38,
                      child: Text(
                        'Runtime: ${formattedRuntime(double.parse('${movie.runtime}'))}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      margin: EdgeInsets.only(top: 5),
                      color: Colors.black38,
                      child: Text(
                        'Revenue: US \$${NumberFormat('###,###,###.##').format(movie.revenue)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      margin: EdgeInsets.only(top: 5),
                      color: Colors.black38,
                      child: Text(
                        'Vote average: ${movie.vote_average}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      margin: EdgeInsets.only(top: 5),
                      color: Colors.black38,
                      child: Text(
                        'Vote count: ${movie.vote_count}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
            margin: EdgeInsets.symmetric(vertical: 5),
            color: Colors.black12,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Genres:',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                if (movie.genres != null)
                  Wrap(
                    children: <Widget>[
                      for (int g = 0; g < (movie.genres ?? []).length; g++)
                        Container(
                          padding: const EdgeInsets.only(right: 6),
                          child: Chip(
                            label: Text('${movie.genres[g]['name']}'),
                          ),
                        )
                    ],
                  )
                else
                  Text(
                    'no genre found',
                    style: TextStyle(color: Colors.white),
                  )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
            margin: EdgeInsets.symmetric(vertical: 5),
            color: Colors.black12,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Spoken language:',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                if (movie.spoken_languages != null)
                  Wrap(
                    children: <Widget>[
                      for (int g = 0;
                          g < (movie.spoken_languages ?? []).length;
                          g++)
                        Container(
                          padding: const EdgeInsets.only(right: 6),
                          child: Chip(
                            label: Text('${movie.spoken_languages[g]['name']}'),
                          ),
                        )
                    ],
                  )
                else
                  Text(
                    'no spoken languages found',
                    style: TextStyle(color: Colors.white),
                  )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
            margin: EdgeInsets.symmetric(vertical: 5),
            color: Colors.black12,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Overview:',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                Text(
                  movie.overview,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
            margin: EdgeInsets.symmetric(vertical: 5),
            color: Colors.black12,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Production companies:',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                if (movie.production_companies != null)
                  Wrap(
                    children: <Widget>[
                      for (int g = 0;
                          g < (movie.production_companies ?? []).length;
                          g++)
                        Container(
                          padding: const EdgeInsets.only(right: 6),
                          child: Chip(
                            avatar: CircleAvatar(
                              backgroundColor: Colors.grey.shade800,
                              child: CachedNetworkImage(
                                imageUrl:
                                    'http://image.tmdb.org/t/p/original${movie.production_companies[g]['logo_path']}',
                                placeholder: (context, url) => Container(
                                    height: 200,
                                    width: 200,
                                    alignment: Alignment(0, 0),
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            label: Text(
                                '${movie.production_companies[g]['name']} - ${movie.production_companies[g]['origin_country']}'),
                          ),
                        )
                    ],
                  )
                else
                  Text(
                    'no production companies found',
                    style: TextStyle(color: Colors.white),
                  )
              ],
            ),
          ),
          Container(
            alignment: Alignment(0, 0),
            margin: EdgeInsets.only(top: 20),
            child: PrimaryButton(
                labelText: 'Back to homepage',
                width: 200,
                loading: false,
                onPressed: () {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }

  String formattedRuntime(double minutes) {
    int m = (minutes % 60).round();
    int h = ((minutes - m) / 60).round();

    String _h = (h > 1) ? 'Hours' : 'Hour';
    String _m = (m > 1) ? 'Minutes' : 'Minute';

    return '$h $_h $m $_m';
  }
}
