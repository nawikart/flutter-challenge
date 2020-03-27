import 'package:flutter/material.dart';

class LeftBamper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 0),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topRight: const Radius.circular(150.0),
                  bottomRight: const Radius.circular(150.0))),
          width: 8,
          height: MediaQuery.of(context).size.height - 100,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: ClipPath(
            clipper: ClipperLeftMenu(),
            child: Container(
              alignment: Alignment(0, 0),
              height: 80,
              width: 60,
              color: Colors.white,
              child: Text(
                'TM ',
                style: TextStyle(fontSize: 22, color: Colors.blue),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ClipperLeftMenu extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 80, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 80, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
