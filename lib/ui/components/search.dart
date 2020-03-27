import 'package:flutter/material.dart';
import '../components/primaryButton.dart';

Future<void> search(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(20),
        height: 165,
        child: Column(
          children: <Widget>[
            Text('Search'),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: TextFormField(
                maxLines: 1,
                decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
              ),
            ),
            PrimaryButton(
                labelText: 'S e a r c h',
                width: 200,
                loading: false,
                onPressed: () {})
          ],
        ),
      );
    },
  );
}
