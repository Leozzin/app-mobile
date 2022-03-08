import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appflutter/constants/host.dart';
import 'package:appflutter/model/Attendance.dart';

class OverallAttendanceCard extends StatefulWidget {
  // final String date;
  // final String day;
  // final String subject;
  // final String classe;
  // final String eleve;
  // final bool attendance;
  final String classe;

  const OverallAttendanceCard({Key key, this.classe}) : super(key: key);

  @override
  _OverallAttendanceCardState createState() => _OverallAttendanceCardState();
}

class _OverallAttendanceCardState extends State<OverallAttendanceCard>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation;
  AnimationController animationController;
  List<Attendance> attendances = [];
  Future<String> getData() async {
    final url = Uri.parse(host +
        '/apis/attendances/week/?classe=' +
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
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2, 0.6, curve: Curves.fastOutSlowIn)));
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
                    // print('>>>>> ${att.id}');
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
                              "${att.date}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 10,
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
                              "${widget.classe}",
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
