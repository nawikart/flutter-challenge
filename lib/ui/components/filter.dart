import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:jiffy/jiffy.dart';
import '../components/primaryButton.dart';

Future<void> filter(BuildContext context) {
  String value = '';
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return BottomSheet(
        onClosing: () {},
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                height: 180,
                child: Column(
                  children: <Widget>[
                    Text('Primary release date'),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: OutlineButton(
                        onPressed: () async {
                          final List<DateTime> picked =
                              await DateRagePicker.showDatePicker(
                                  context: context,
                                  initialFirstDate: new DateTime.now(),
                                  initialLastDate: (new DateTime.now())
                                      .add(new Duration(days: 7)),
                                  firstDate: new DateTime(2015),
                                  lastDate: new DateTime(2022));
                          if (picked != null && picked.length == 2) {
                            setState(() {
                              value =
                                  '${Jiffy(picked[0]).yMMMMd} - ${Jiffy(picked[1]).yMMMMd}';
                            });
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.date_range),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text('${value}'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PrimaryButton(
                        labelText: 'F i l t e r',
                        width: 200,
                        loading: false,
                        onPressed: () {
                          return showDialog<void>(
                            context: context,
                            barrierDismissible: true, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    'Maaf, untuk filter berdasarkan date range tidak bisa dikarenakan saya tidak menemukan API doc untuk case ini. Silahkan untuk melanjutkan review "Sorting" pada tab berikutnya. trimakasih'),
                              );
                            },
                          );
                        })
                  ],
                ));
          });
        },
      );
    },
  );
}
