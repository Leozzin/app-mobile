import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:appflutter/constants/host.dart';
import 'package:localstorage/localstorage.dart';
import 'package:appflutter/model/Enseignant.dart';
import 'package:appflutter/constants/constants.dart';

class PostState with ChangeNotifier {
  LocalStorage storage = LocalStorage("usertoken");
  Future<bool> loginNow(String username, String password) async {
    try {
      final url = Uri.parse(host + '/logtst/');
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      var data = json.decode(response.body) as Map;
      // print(data);
      if (data.containsKey('token')) {
        storage.setItem('token', data['token']);
        final String url = host + '/apis/profile/?token=' + data['token'];
        final response = await http.get(url);
        List<Enseignant> datas = [];
        if (response.statusCode == 200) {
          var datass = json.decode(response.body) as List;
          datas = datass
              .map<Enseignant>((json) => Enseignant.fromJson(json))
              .toList();
          ens = datas[0];
          await storage.setItem('nom', ens.nom);
          await storage.setItem('prenom', ens.prenom);
          await storage.setItem('image', ens.image);
          await storage.setItem('email', ens.email);
        }
        // print(storage.getItem('token'));
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> changePass(String oldpass, String newpass) async {
    var token = storage.getItem('token');
    try {
      final url = Uri.parse(host + '/apis/profile/changePass/');
      http.Response response = await http.post(
        url,
        headers: {
          "content-type": "application/json",
        },
        body: json
            .encode({"oldpass": oldpass, "newpass": newpass, "token": token}),
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
