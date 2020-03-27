import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../components/primaryButton.dart';

Future<void> sorting(BuildContext context) {
  //Allowed Values: , original_order.asc, original_order.desc, release_date.asc, release_date.desc, title.asc, title.desc, vote_average.asc, vote_average.desc
  Map criteria = {
    'original_order': {
      'label': 'Original order',
      'checked': false,
      'orderBy': null
    },
    'release_date': {
      'label': 'Release date',
      'checked': false,
      'orderBy': null
    },
    'title': {'label': 'Title', 'checked': false, 'orderBy': null},
    'vote_average': {
      'label': 'Vote average',
      'checked': false,
      'orderBy': null
    },
  };

  List criteria2list = [];
  criteria.forEach((k, v) {
    criteria2list.add(k);
  });

  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return BottomSheet(
        onClosing: () {},
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Container(
                padding: EdgeInsets.all(8),
                height: 360,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Advanced Sorting',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        for (int i = 0; i < criteria2list.length; i++)
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 2),
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xffeeeeee),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    onChanged: (val) {
                                      setState(() => criteria[criteria2list[i]]
                                              ['checked'] =
                                          !(criteria[criteria2list[i]]
                                                  ['checked'] ??
                                              false));
                                    },
                                    value: criteria[criteria2list[i]]
                                            ['checked'] ??
                                        false,
                                  ),
                                  Text(criteria[criteria2list[i]]['label']),
                                  Spacer(),
                                  Container(
                                    width: 100,
                                    child: Row(
                                      children: <Widget>[
                                        Switch(
                                          onChanged: (val) {
                                            setState(() =>
                                                criteria[criteria2list[i]]
                                                        ['orderBy'] =
                                                    !(criteria[criteria2list[i]]
                                                            ['orderBy'] ??
                                                        false));
                                          },
                                          value: criteria[criteria2list[i]]
                                                  ['orderBy'] ??
                                              false,
                                        ),
                                        Text(((criteria[criteria2list[i]]
                                                        ['orderBy'] ??
                                                    false) ==
                                                false)
                                            ? 'Asc'
                                            : 'Desc'),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: PrimaryButton(
                          labelText: 'S o r t i n g',
                          width: 200,
                          loading: false,
                          onPressed: () async {
                            SharedPreferences.getInstance().then((prefs) {
                              String criteria2string = '';
                              criteria.forEach((k, v) {
                                if (criteria[k]['checked']) {
                                  criteria2string = criteria2string +
                                      '&sort_by=${k}.${(criteria[k]['orderBy'] ?? false) == true ? 'desc' : 'asc'}';
                                }
                              });

                              prefs.setString(
                                  'sortingCriteria', criteria2string);
                              Navigator.pop(context);
                            });
                          }),
                    )
                  ],
                ));
          });
        },
      );
    },
  );
}
