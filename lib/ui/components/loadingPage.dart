import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 3,
            ),
          ),
        ));
  }
}
