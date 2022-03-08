import 'package:appflutter/constants/Theme.dart';
import 'package:appflutter/model/Enseignant.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/screens/login.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import 'drawer-tile.dart';
import 'package:http/http.dart' as http;
import 'package:appflutter/constants/host.dart';
import 'package:appflutter/constants/constants.dart';
import 'package:appflutter/model/Enseignant.dart';

class AddDrower extends StatefulWidget {
  final String currentPage;

  AddDrower({this.currentPage});

  @override
  _AddDrowerState createState() => _AddDrowerState();
}

class _AddDrowerState extends State<AddDrower> {
  // List<Enseignant> data = [];
  // LocalStorage storage = LocalStorage('usertoken');

  // Future<String> getData() async {
  //   String token;
  //   LocalStorage storage = LocalStorage('usertoken');
  //   token = storage.getItem('token');
  //   final String url = host + '/apis/profile/?token=' + token;
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var datas = json.decode(response.body) as List;
  //     setState(() {
  //       this.data =
  //           datas.map<Enseignant>((json) => Enseignant.fromJson(json)).toList();
  //       ens = data[0];
  //     });
  //   }
  //   return "Sucess";
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");
    _logoutnow() {
      storage.clear();
      Navigator.of(context).pushReplacementNamed(LoginScreens.routeName);
    }

    String nom = storage.getItem('nom');
    String prenom = storage.getItem('prenom');
    String image = storage.getItem('image');
    return Drawer(
      child: Container(
          child: Column(children: [
        DrawerHeader(
            decoration: BoxDecoration(color: MaterialColors.drawerHeader),
            padding: const EdgeInsets.only(left: 10, bottom: 1.0, top: 8.0),
            child: Container(
                // padding: const EdgeInsets.only(bottom: 0.5),
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(75)),
                        child: Image.network(host + "/media/" + image),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                      child: Text(nom + ' ' + prenom,
                          style: TextStyle(color: Colors.white, fontSize: 21)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 8.0),
                          //   child: Container(
                          //       padding: EdgeInsets.symmetric(horizontal: 6),
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(4),
                          //           color: MaterialColors.label),
                          //       child: Text("Pro",
                          //           style: TextStyle(
                          //               color: Colors.white, fontSize: 16))),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 16.0),
                          //   child: Text("Seller",
                          //       style: TextStyle(
                          //           color: MaterialColors.muted, fontSize: 16)),
                          // ),
                        ],
                      ),
                    )
                  ],
                ))),
        Expanded(
            child: ListView(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            DrawerTile(
                icon: Icons.dashboard,
                onTap: () {
                  if (widget.currentPage != "Home")
                    Navigator.pushReplacementNamed(context, '/home');
                },
                iconColor: Colors.black,
                title: "Home",
                isSelected: widget.currentPage == "Home" ? true : false),
            DrawerTile(
                icon: Icons.group,
                onTap: () {
                  if (widget.currentPage != "eleves")
                    Navigator.pushReplacementNamed(context, '/eleves');
                },
                iconColor: Colors.black,
                title: "Gestion eleves",
                isSelected: widget.currentPage == "eleves" ? true : false),
            DrawerTile(
                icon: Icons.camera_front,
                onTap: () {
                  if (widget.currentPage != "attendances")
                    Navigator.pushReplacementNamed(context, '/attendances');
                },
                iconColor: Colors.black,
                title: "Gestion présence",
                isSelected: widget.currentPage == "attendances" ? true : false),
            DrawerTile(
                icon: Icons.account_circle,
                onTap: () {
                  if (widget.currentPage != "Profile")
                    Navigator.pushReplacementNamed(context, '/profile');
                },
                iconColor: Colors.black,
                title: "Profile",
                isSelected: widget.currentPage == "Profile" ? true : false),
            DrawerTile(
                icon: Icons.open_in_browser,
                onTap: () {
                  _logoutnow();
                },
                iconColor: Colors.black,
                title: "deconnexion",
                isSelected: widget.currentPage == "Sign Up" ? true : false),
          ],
        ))
      ])),
    );
  }
}
