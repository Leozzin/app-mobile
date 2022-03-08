import 'package:appflutter/screens/login.dart';
import 'package:appflutter/screens/oubliemotdepasse.dart';
import 'package:appflutter/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/state/poststate.dart';
import 'package:appflutter/widgets/appdrower.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:appflutter/widgets/navbar.dart';
import 'package:appflutter/constants/Theme.dart';

import 'attendances.dart';
import 'eleves.dart';

class HomeScreens extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: Navbar(
//           title: "Home",
//           searchBar: true,
//           // categoryOne: 'eee',
//           // // categoryTwo: "Best Deals",
//         ),
//         backgroundColor: MaterialColors.bgColorScreen,
//         // key: _scaffoldKey,
//         drawer: AddDrower(currentPage: "Home"),
//         body: Container());
//   }
// }
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");
    _logoutnow() {
      storage.clear();
      Navigator.of(context).pushReplacementNamed(LoginScreens.routeName);
    }

    return Scaffold(
        appBar: Navbar(
          title: "Home",
//           // categoryOne: 'eee',
//           // // categoryTwo: "Best Deals",
        ),
        backgroundColor: MaterialColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: AddDrower(currentPage: "Home"),
//    body: Container());
//   }
        //backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Welcome To Classroom Care System",
                  style: TextStyle(
                      color: MaterialColors.info,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20.0,
                    children: <Widget>[
                      SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                          color: Colors.white,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              ElevesScreens.routeName);
                                    }, // handle your image tap here
                                    child: Image.asset(
                                      "assets/classroom.png",
                                      width: 64.0,
                                    )),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Gestion Eleves",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                          color: Colors.white,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              AttendancesScreens.routeName);
                                    }, // handle your image tap here
                                    child: Image.asset(
                                      "assets/attendance.png",
                                      width: 64.0,
                                    )),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Gestion\nAttendances",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                          color: Colors.white,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              ProfileScreens.routeName);
                                    }, // handle your image tap here
                                    child: Image.asset(
                                      "assets/profile.png",
                                      width: 64.0,
                                    )),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                          color: Colors.white,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      _logoutnow();
                                    }, // handle your image tap here
                                    child: Image.asset(
                                      "assets/exit.png",
                                      width: 64.0,
                                    )),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Déconnexion",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
        ));
  }
}
