import 'package:appflutter/screens/attendances.dart';
import 'package:appflutter/screens/eleves.dart';
import 'package:appflutter/screens/home.dart';
import 'package:appflutter/screens/login.dart';
import 'package:appflutter/screens/oubliemotdepasse.dart';
import 'package:appflutter/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:appflutter/state/poststate.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");
    return ChangeNotifierProvider(
      create: (ctx) => PostState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.orange,
        ),
        home: FutureBuilder(
          future: storage.ready,
          builder: (context, snapshop) {
            if (snapshop.data == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (storage.getItem('token') == null) {
              return LoginScreens();
            }
            return HomeScreens();
          },
        ),
        routes: {
          HomeScreens.routeName: (ctx) => HomeScreens(),
          AttendancesScreens.routeName: (ctx) => AttendancesScreens(),
          ElevesScreens.routeName: (ctx) => ElevesScreens(),
          ProfileScreens.routeName: (ctx) => ProfileScreens(),
          // PostDetailsScreens.routeName: (ctx) => PostDetailsScreens(),
          // CategoryScreens.routeName: (ctx) => CategoryScreens(),
          LoginScreens.routeName: (ctx) => LoginScreens(),
          Obuliecreens.routeName:(ctx)=> Obuliecreens(),
          // RegisterScreens.routeName: (ctx) => RegisterScreens(),
        },
      ),
    );
  }
}
