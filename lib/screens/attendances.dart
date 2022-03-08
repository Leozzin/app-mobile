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

String cls;
String matiere;

class DropDownMatiere extends StatefulWidget {
  @override
  _DropDownMatiereState createState() => _DropDownMatiereState();
}

class _DropDownMatiereState extends State<DropDownMatiere> {
  String chosenMatiere;
  List<String> matieres = [];
  Future<String> getMatieres() async {
    final String url = host + '/apis/matieres/?classe=' + cls;
    var res = await http.get(
      Uri.parse(url),
    );
    setState(() {
      matieres = (jsonDecode(res.body) as List<dynamic>).cast<String>();
      // data = json.decode(res.body) as List;
    });
    // matieres = (jsonDecode(res.body) as List<dynamic>).cast<String>();

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getMatieres();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      focusColor: Colors.white,
      value: this.chosenMatiere,
      items: this.matieres.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
            ));
      }).toList(),
      hint: Text(
        'Sélectionner une matiere',
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: (String value) {
        setState(() {
          this.chosenMatiere = value;
          matiere = value;
        });
      },
    );
  }
}

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
  List<String> cameras = [];
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
    final String url = host + '/apis/matieres/?classe=' + cls;
    var res = await http.get(
      Uri.parse(url),
    );
    setState(() {
      matieres = (jsonDecode(res.body) as List<dynamic>).cast<String>();
      // data = json.decode(res.body) as List;
    });
    // matieres = (jsonDecode(res.body) as List<dynamic>).cast<String>();

    return "Sucess";
  }

  Future<String> getCameras() async {
    final String url = host + '/apis/cameras/';
    var res = await http.get(
      Uri.parse(url),
    );
    setState(() {
      cameras = (jsonDecode(res.body) as List<dynamic>).cast<String>();
      // data = json.decode(res.body) as List;
    });
    // matieres = (jsonDecode(res.body) as List<dynamic>).cast<String>();

    return "Sucess";
  }

  void saveAttendance() async {
    final url = Uri.parse(host + '/apis/attendances/take/');
    http.Response response = await http.post(
      url,
      headers: {
        "content-type": "application/json",
      },
      body: json.encode({"classe": cls, "matiere": matiere}),
    );
    var data = json.decode(response.body) as Map;
    if (data.containsKey('save')) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Présence enregistré!'),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AttendancesScreens.routeName);
                  },
                  child: Text('OK'),
                )
              ],
            );
          });
    }
    else{
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Erreur d\'enregistrement!'),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AttendancesScreens.routeName);
                  },
                  child: Text('OK'),
                )
              ],
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getClasses();
  }

  @override
  Widget build(BuildContext context) {
    // _remplirMatiere() async {
    //   await this.getMatieres();
    // }

    // String _chosenValue;
    _showCupertinoDialog() async {
      // await this.getClasses();
      // await this.getCameras();
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
                          value: cls,
                          items: this
                              .classes
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
                            'Sélectionner une classe',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              this._chosenclasse = value;
                              cls = value;
                              // getMatieres();
                            });
                          },
                        ),
                        DropDownMatiere(),
                        RaisedButton(
                          onPressed: () {
                            saveAttendance();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45),
                          ),
                          padding: EdgeInsets.all(20),
                          color: MaterialColors.primary,
                          child: Text(
                            'Enregistrer',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                        // DropdownButton<String>(
                        //   focusColor: Colors.white,
                        //   value: this._chosenmatiere,
                        //   items: this
                        //       .matieres
                        //       .map<DropdownMenuItem<String>>((String value) {
                        //     return DropdownMenuItem<String>(
                        //       value: value,
                        //       child: Text(
                        //         value,
                        //         style: TextStyle(color: Colors.black),
                        //       ),
                        //     );
                        //   }).toList(),
                        //   hint: Text(
                        //     'Sélectionner une matiere',
                        //     style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w500),
                        //   ),
                        //   onChanged: (String value) {
                        //     setState(() {
                        //       this._chosenmatiere = value;
                        //     });
                        //   },
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    }

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
