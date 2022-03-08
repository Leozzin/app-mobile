import 'dart:convert';
import 'package:appflutter/constants/host.dart';
import 'package:appflutter/model/Attendance.dart';
import 'package:flutter/material.dart';
import '../model/Eleves.dart';
import 'package:http/http.dart' as http;

class ElevesProvider with ChangeNotifier {
  List<Eleves> data;
  String classe;
  ElevesProvider(this.classe);

  Future getData(context) async {
    print("pppp >>> $classe");
    final url =
        Uri.parse(host + '/apis/classe/?classe=' + classe + '&format=json');
    final response = await http.get(url);
    print(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var datas = json.decode(response.body) as List;
      print(datas);
      this.data = datas.map<Eleves>((json) => Eleves.fromJson(json)).toList();
      print(this.data);
      this.notifyListeners();
    }
  }
}

class EleveProvider with ChangeNotifier {
  Eleves data;

  Future getData(context, id) async {
    final url = Uri.parse(host + '/apis/' + id.toString() + '?format=json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var datas = json.decode(response.body);
      this.data = Eleves.fromJson(datas);
      this.notifyListeners();
    }
  }
}

class AttendanceProvider with ChangeNotifier {
  Attendance data;
  Future getData(context, id) async {
    final url = Uri.parse(
        host + '/apis/attendances/' + id.toString() + '/?format=json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var datas = json.decode(response.body);
      this.data = Attendance.fromJson(datas);
    }
  }
}
