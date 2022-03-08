import 'package:appflutter/api/api.dart';
import 'package:appflutter/constants/Theme.dart';
import 'package:appflutter/constants/constants.dart';
import 'package:appflutter/screens/attendances.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appflutter/constants/host.dart';
import 'package:appflutter/model/Attendances.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';

class AttendanceCard extends StatefulWidget {
  // final String starttime;
  // final String endtime;
  // final String subject;
  // final String classe;
  // final String eleve;
  // final bool attendance;
  final String classe;

  const AttendanceCard({Key key, this.classe}) : super(key: key);

  @override
  _AttendanceCardState createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation;
  AnimationController animationController;

  List<Attendance> attendances = [];
  Future<String> getData() async {
    final url = Uri.parse(host +
        '/apis/attendances/today/?classe=' +
        widget.classe +
        '&format=json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var datas = json.decode(response.body) as List;
      if (this.mounted) {
        setState(() {
          this.attendances = datas
              .map<Attendance>((json) => Attendance.fromJson(json))
              .toList();
        });
      }
    }
    return "Sucess";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    // TODO: implement dispose

    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.classe == '') {
      return Wrap(
        children: [],
      );
    }
    this.getData();
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    Wrap ll = Wrap(
      children: [],
    );
    ll.children.addAll(attendances.map((att) => AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Transform(
                transform: Matrix4.translationValues(
                    delayedAnimation.value * width, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AttendanceDialogBox(
                            id: att.id,
                            att: att,
                          );
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 3),
                          //blurRadius: 3,
                          //spreadRadius: 1,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${att.start}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${att.end}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${att.matiere}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${att.classe}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${att.eleve}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: att.status == 'Present'
                                ? Colors.green
                                : Colors.red,
                          ),
                          child: Center(
                            child: att.status == 'Present'
                                ? Text(
                                    "P",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  )
                                : Text(
                                    "A",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )));
    return ll;
  }
}

class AttendanceDialogBox extends StatefulWidget {
  final int id;
  final Attendance att;
  const AttendanceDialogBox({Key key, this.id, this.att}) : super(key: key);

  @override
  _AttendanceDialogBoxState createState() => _AttendanceDialogBoxState();
}

class _AttendanceDialogBoxState extends State<AttendanceDialogBox> {
  String _status;
  String initStatus;

  Future<Widget> changeStatus(st) async {
    try {
      final url = Uri.parse(host + '/apis/attendances/change/');
      http.Response response = await http.post(
        url,
        headers: {
          "content-type": "application/json",
        },
        body: json.encode({"id": widget.att.id, "status": _status}),
      );
      var data = json.decode(response.body) as Map;
      if (data.containsKey('isChanged')) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Status est changé!"),
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
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Erreur!"),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                )
              ],
            );
          });
    } catch (e) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Erreur!"),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
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
    _status = widget.att.status;
    initStatus = _status;
  }

  @override
  Widget build(BuildContext context) {
    final editBtn = RaisedButton(
      onPressed: (initStatus != _status) ? () => changeStatus(_status) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      color: MaterialColors.primary,
      child: Text(
        'Modifier',
        style: TextStyle(color: Colors.white),
      ),
    );
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: Constants.padding,
                top: Constants.padding,
                right: Constants.padding,
                bottom: Constants.padding),
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
                Text(
                  widget.att.eleve,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '-Classe:     ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(widget.att.classe)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '-Matiere:    ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(widget.att.matiere)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '-Heure:       ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(widget.att.start.toString() +
                            ' - ' +
                            widget.att.end.toString())
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        RadioButton(
                            description: "Present",
                            value: "Present",
                            groupValue: _status,
                            onChanged: (value) {
                              setState(() {
                                _status = value;
                              });
                            }),
                        RadioButton(
                            description: "Absent",
                            value: "Absent",
                            groupValue: _status,
                            onChanged: (value) {
                              setState(() {
                                _status = value;
                              });
                            }),
                      ],
                    ),
                    editBtn
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
