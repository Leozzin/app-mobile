import 'package:appflutter/widgets/AttendanceCard.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appflutter/constants/host.dart';

// import 'package:appfultter/widgets/AttendanceCard.dart';
String cls = '';

class TodayAttendance extends StatefulWidget {
  static const routeName = '/todayattendance';
  @override
  _TodayAttendanceState createState() => _TodayAttendanceState();
}

class _TodayAttendanceState extends State<TodayAttendance> {
  String _chosenValue;
  String classe = '';
  List<String> data = [];

  Future<String> getSWData() async {
    String token;
    LocalStorage storage = LocalStorage('usertoken');
    token = storage.getItem('token');
    final String url = host + '/apis/classes/?token=' + token;
    var res = await http.get(
      Uri.parse(url),
    );
    setState(() {
      data = (jsonDecode(res.body) as List<dynamic>).cast<String>();
      // data = json.decode(res.body) as List;
    });

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
    cls = '';
  }

  @override
  Widget build(BuildContext context) {
    final dropDownBtn = DropdownButton<String>(
      focusColor: Colors.white,
      value: _chosenValue,
      //elevation: 5,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: data.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      hint: Text(
        "Sélectionner la Classe",
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: (String value) {
        setState(() {
          _chosenValue = value;
          cls = _chosenValue;
        });
      },
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            dropDownBtn,
            AttendanceCard(
              classe: cls,
            )
          ],
        ),
      ),
    );
  }
}
