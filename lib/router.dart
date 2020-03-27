import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'ui/movie/list.dart';
import 'ui/movie/detail.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _movieListHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          MovieListScreen());

  static Handler _movieDetailHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          MovieDetailScreen(params['id'][0]));

  //////////////////
  static void setupRouter() {
    router.define('/',
        handler: _movieListHandler, transitionType: TransitionType.fadeIn);

    router.define('/movie/:id',
        handler: _movieDetailHandler, transitionType: TransitionType.fadeIn);
  }
}
