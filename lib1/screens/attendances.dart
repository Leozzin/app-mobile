import 'package:appflutter/constants/constants.dart';
import 'package:appflutter/constants/host.dart';
import 'package:appflutter/screens/gestionEleves.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/state/poststate.dart';
import 'package:appflutter/widgets/appdrower.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:appflutter/widgets/navbar.dart';
import 'package:appflutter/constants/Theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'OverallAttendance.dart';
import 'TodayAttendance.dart';

class AttendancesScreens extends StatefulWidget {
  static const routeName = '/attendances';

  @override
  _AttendancesScreens createState() => _AttendancesScreens();
}

class _AttendancesScreens extends State<AttendancesScreens> {
  String _chosenclasse;
  String _chosenmatiere;
  String _chosencamera;
  bool isChecked = false;
  List<String> classes = [];
  List<String> matieres = [];
  Future<String> getClasses() async {
    String token;
    LocalStorage storage = LocalStorage('usertoken');
    token = storage.getItem('token');
    final String url = host + '/apis/classes/?token=' + token;
    var res = await http.get(
      Uri.parse(url),
    );
    setState(() {
      classes = (jsonDecode(res.body) as List<dynamic>).cast<String>();
      // data = json.decode(res.body) as List;
    });

    return "Sucess";
  }

  Future<String> getMatieres() async {
    final String url = host + '/apis/matieres/?classe=' + _chosenclasse;
    var res = await http.get(
      Uri.parse(url),
    );
    // setState(() {
    //   matieres = (jsonDecode(res.body) as List<dynamic>).cast<String>();
    //   // data = json.decode(res.body) as List;
    // });
    matieres = (jsonDecode(res.body) as List<dynamic>).cast<String>();

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _remplirMatiere() async {
    //   await this.getMatieres();
    // }

    // String _chosenValue;
    _showCupertinoDialog() async {
      await this.getClasses();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.padding)),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 300,
                    padding: EdgeInsets.only(
                      left: Constants.padding,
                      top: Constants.padding,
                      right: Constants.padding,
                      bottom: Constants.padding,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Constants.padding),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 10),
                            blurRadius: 10,
                          )
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        DropdownButton<String>(
                          focusColor: Colors.white,
                          value: _chosenclasse,
                          items: classes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            'Selection un classe',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _chosenclasse = value;
                              this.getMatieres();
                            });
                          },
                        ),
                        DropdownButton<String>(
                          focusColor: Colors.white,
                          value: _chosenmatiere,
                          items: matieres
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            'Selection une matiere',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _chosenmatiere = value;
                            });
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    }
    // _showCupertinoDialog() {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return StatefulBuilder(
    //             builder: (BuildContext context, StateSetter setState) {
    //           return AlertDialog(
    //             title: new Text("Prendre les présences"),
    //             content: Container(
    //               // height: 300,
    //               // width: 200,
    //               child: Column(
    //                 children: <Widget>[
    //                   // new Text("Choisir une classe :"),
    //                   new DropdownButton<String>(
    //                     hint: Text('Choisir une  classe..'),
    //                     value: _chosenclasse,
    //                     underline: Container(),
    //                     items: <String>[
    //                       'I\'m not able to help',
    //                       'Unclear description',
    //                       'Not available at set date and time',
    //                       'Other'
    //                     ].map((String value) {
    //                       return new DropdownMenuItem<String>(
    //                         value: value,
    //                         child: new Text(
    //                           value,
    //                           style: TextStyle(fontWeight: FontWeight.w500),
    //                         ),
    //                       );
    //                     }).toList(),
    //                     onChanged: (String value) {
    //                       setState(() {
    //                         _chosenclasse = value;
    //                       });
    //                     },
    //                   ),
    //                   new DropdownButton<String>(
    //                     hint: Text('Choisir une matiere..'),
    //                     value: _chosenmatiere,
    //                     underline: Container(),
    //                     items: <String>[
    //                       'I\'m not able to help',
    //                       'Unclear description',
    //                       'Not available at set date and time',
    //                       'Other'
    //                     ].map((String value) {
    //                       return new DropdownMenuItem<String>(
    //                         value: value,
    //                         child: new Text(
    //                           value,
    //                           style: TextStyle(fontWeight: FontWeight.w500),
    //                         ),
    //                       );
    //                     }).toList(),
    //                     onChanged: (String value) {
    //                       setState(() {
    //                         _chosenmatiere = value;
    //                       });
    //                     },
    //                   ),
    //                   new DropdownButton<String>(
    //                     hint: Text('Choisir une  camera..'),
    //                     value: _chosencamera,
    //                     underline: Container(),
    //                     items: <String>[
    //                       'I\'m not able to help',
    //                       'Unclear description',
    //                       'Not available at set date and time',
    //                       'Other'
    //                     ].map((String value) {
    //                       return new DropdownMenuItem<String>(
    //                         value: value,
    //                         child: new Text(
    //                           value,
    //                           style: TextStyle(fontWeight: FontWeight.w500),
    //                         ),
    //                       );
    //                     }).toList(),
    //                     onChanged: (String value) {
    //                       setState(() {
    //                         _chosencamera = value;
    //                       });
    //                     },
    //                   ),

    //                   new Checkbox(
    //                     //  label: 'This is the label text',
    //                     //  padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //                     value: isChecked,
    //                     onChanged: (value) {
    //                       setState(() {
    //                         isChecked = value;
    //                       });
    //                     },
    //                   )
    //                 ],
    //               ),
    //             ),
    //             actions: <Widget>[
    //               FlatButton(
    //                 textColor: Color(0xFF6200EE),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: Text('Annuler'),
    //               ),
    //               FlatButton(
    //                 textColor: Color(0xFF6200EE),
    //                 onPressed: () {},
    //                 child: Text('Prendre'),
    //               ),
    //             ],
    //           );
    //         });
    //       });
    // }

    final takeattendancebutton = Padding(
      padding: EdgeInsets.symmetric(vertical: 24.24),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _showCupertinoDialog();
        },
        padding: EdgeInsets.all(20),
        color: MaterialColors.primary,
        child: Text('Prendre les présences',
            style: TextStyle(color: Colors.white)),
      ),
    );
    return Scaffold(
      appBar: Navbar(
        title: "Présences",
        // categoryOne: 'eee',
        // // categoryTwo: "Best Deals",
      ),
      backgroundColor: MaterialColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: AddDrower(currentPage: "attendances"),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              // width: 300.0,
              width: MediaQuery.of(context).size.height * 0.40,
              child: takeattendancebutton,
            ),
            DefaultTabController(
              length: 2, // length of tabs
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      child: TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black26,
                        indicatorColor: Colors.black,
                        tabs: [
                          Tab(text: "Aujourd'hui"),
                          Tab(text: 'Globalement'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.68, //height of TabBarView
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TabBarView(
                      children: <Widget>[
                        TodayAttendance(),
                        OverallAttendance(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
