import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:appflutter/constants/host.dart';
import 'package:localstorage/localstorage.dart';

class PostChange extends ChangeNotifier {
  LocalStorage storage = LocalStorage("usertoken");
  
}
