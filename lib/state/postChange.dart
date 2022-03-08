import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:appflutter/constants/host.dart';
import 'package:localstorage/localstorage.dart';

class PostChange extends ChangeNotifier {
  LocalStorage storage = LocalStorage("usertoken");
  Future<bool> changePass(String oldpass, String newpass) async {
    try {
      final url = Uri.parse(host + '/profile/changePass/');
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          'oldpass': oldpass,
          'newpass': newpass,
          'token': storage.getItem('token')
        }),
      );
      var data = json.decode(response.body) as Map;
      if (data.containsKey('isChanged')) {
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }
}
