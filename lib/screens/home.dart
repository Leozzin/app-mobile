import 'package:appflutter/screens/login.dart';
import 'package:appflutter/screens/oubliemotdepasse.dart';
import 'package:appflutter/screens/profile.dart';
import 'package:appflutter/widgets/drawer-tile.dart';
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

    final makeListTile = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.white),
        ),
        title: Text(
          "Introduction to Driving",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text(" Intermediate", style: TextStyle(color: Colors.white))
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));
    final makeCard = Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile,
      ),
    );

    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return makeCard;
        },
      ),
    );
    final mybody = SafeArea(
        child: ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Card(
            child: ListTile(
          title: Text("Gestion Eleves",
              style: TextStyle(
                  color: MaterialColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              textAlign: TextAlign.center),
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 48.0,
            child: Image.asset('assets/classroom.png'),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () =>
              {Navigator.pushReplacementNamed(context, '/attendances')},
        )),
        Card(
          child: ListTile(
            title: Text("Gestion Présences",
                style: TextStyle(
                    color: MaterialColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                textAlign: TextAlign.center),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 48.0,
              child: Image.asset('assets/attendance.png'),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, '/attendances')},
          ),
        ),
        Card(
          child: ListTile(
            title: Text("Profil",
                style: TextStyle(
                    color: MaterialColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                textAlign: TextAlign.center),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 48.0,
              child: Image.asset('assets/profile.png'),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, '/attendances')},
          ),
        ),
      ],
    ));
    final tt = Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: NetworkImage(
                      "https://image.freepik.com/free-photo/book-with-green-board-background_1150-3837.jpg"),
                  fit: BoxFit.fitWidth)),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0.9),
              ])),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 8,
                        blurRadius: 10,
                        offset: Offset(0, 0))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  )),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.28,
              ),
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 12.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Card(
                        shadowColor: MaterialColors.active,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .012,
                        ),
                        child: ListTile(
                          title: Text("Gestion Eleves",
                              style: TextStyle(
                                  color: MaterialColors.caption,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                              textAlign: TextAlign.center),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 48.0,
                            child: Image.asset('assets/classroom.png'),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () => {
                            Navigator.pushReplacementNamed(context, '/eleves')
                          },
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    Card(
                        shadowColor: MaterialColors.active,
                        child: ListTile(
                          title: Text("Gestion Présences",
                              style: TextStyle(
                                  color: MaterialColors.caption,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                              textAlign: TextAlign.center),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 48.0,
                            child: Image.asset('assets/attendance.png'),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () => {
                            Navigator.pushReplacementNamed(
                                context, '/attendances')
                          },
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    Card(
                        shadowColor: MaterialColors.active,
                        child: ListTile(
                          title: Text("Gestion Profil",
                              style: TextStyle(
                                  color: MaterialColors.caption,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                              textAlign: TextAlign.center),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 48.0,
                            child: Image.asset('assets/profile.png'),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () => {
                            Navigator.pushReplacementNamed(context, '/profile')
                          },
                        )),
                  ],
                ),
              )),
        )
      ],
    );
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
      body: tt,
    );
  }
}
