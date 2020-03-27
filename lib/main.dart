import 'package:flutter/material.dart';
import 'router.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo TMDB',
        theme: ThemeData(
            primarySwatch: Colors.blue, fontFamily: 'GothamRounded-Medium'),
        initialRoute: '/',
        onGenerateRoute: FluroRouter.router.generator);
  }
}
