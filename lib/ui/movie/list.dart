import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../components/leftBamper.dart';
import '../components/filter.dart';
import '../components/sorting.dart';
import '../components/loadingPage.dart';
import '../../api/movie.dart';
import '../../model/movie.dart';

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  int _selectedTabIndex = 0;
  Future<List<MovieModel>> movies;

  @override
  void initState() {
    super.initState();
    movies = MovieApi().getList('');
  }

  void _selectTab(int index) {
    if (index == 0) {
      filter(context).then((res) {
        setState(() {
          _selectedTabIndex = index;
        });
      });
    } else if (index == 1) {
      sorting(context).then((res) {
        SharedPreferences.getInstance().then((prefs) {
          final criteria2string = prefs.getString('sortingCriteria');
          setState(() {
            if (criteria2string != '') {
              movies = MovieApi().getList(criteria2string);
            }
            _selectedTabIndex = index;
          });
        });
      });
    } else {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text('The Movie DB'),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: FutureBuilder<List<MovieModel>>(
                future: movies,
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
                      else if (snapshot.data.length == 0)
                        return Center(
                          child: Text('Not Found',
                              style: TextStyle(color: Colors.red)),
                        );
                      else
                        return Container(
                          child: Wrap(
                            children: <Widget>[
                              for (int i = 0;
                                  i <
                                      ((snapshot.data.length > 24)
                                          ? 24
                                          : snapshot.data.length);
                                  i++)
                                _item(snapshot.data[i])
                            ],
                          ),
                        );
                  }
                },
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.blue,
            unselectedItemColor: Color(0xffcccccc),
            selectedItemColor: Colors.white,
            currentIndex: _selectedTabIndex,
            onTap: _selectTab,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.filter_list),
                title: Text('Filter', style: TextStyle(fontSize: 10)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sort),
                title: Text('Sorting', style: TextStyle(fontSize: 10)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.close),
                title: Text('Close', style: TextStyle(fontSize: 10)),
              ),
            ],
          ),
        ),
        LeftBamper()
      ],
    );
  }

  Widget _item(MovieModel movie) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/movie/${movie.id}');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Card(
            elevation: 4,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.white,
            child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width / 2 - 28,
                child: Column(
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
                        color: Colors.white,
                        height: 70,
                        width: MediaQuery.of(context).size.width - 140,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 9, 4, 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                movie.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: theme.primaryColor),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.access_time,
                                        size: 12, color: theme.primaryColor),
                                    Container(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Text(
                                        movie.release_date,
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: theme.primaryColor),
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(Icons.rate_review,
                                        size: 12, color: theme.primaryColor),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        ' ${movie.vote_average}',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: theme.primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ))),
      ),
    );
  }
}
