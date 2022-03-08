import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:appflutter/state/poststate.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/constants/Theme.dart';
import 'package:localstorage/localstorage.dart';
import 'package:appflutter/constants/host.dart';
import 'package:appflutter/state/postChange.dart';
import 'package:appflutter/screens/home.dart';
import 'package:http/http.dart' as http;
//widgets
import 'package:appflutter/widgets/navbar.dart';
import 'package:appflutter/widgets/appdrower.dart';
import 'package:provider/provider.dart';

class ProfileScreens extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfileScreens createState() => _ProfileScreens();
}

class _ProfileScreens extends State<ProfileScreens> {
  final _form = GlobalKey<FormState>();
  String _oldpass;
  String _newpass;
  String _conpass;
  LocalStorage storage = LocalStorage("usertoken");

  void _changeNow() async {
    bool isMatch = true;
    if (_conpass != _newpass) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                "Confirmation mot de passe ne correspond pas au nouvelle mot de passe!"),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isMatch = false;
                  });
                },
                child: Text("Ok"),
              ),
            ],
          );
        },
      );
    }
    var isValid = _form.currentState.validate();
    if ((!isValid) || (!isMatch)) {
      return;
    }
    _form.currentState.save();
    // bool isChanged = await changePass(_oldpass, _newpass);
    bool isChanged = await Provider.of<PostState>(context, listen: false)
        .changePass(_oldpass, _newpass);
    if (!isChanged) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("password change successfully"),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(ProfileScreens.routeName);
                },
                child: Text("Ok"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Mot de passe courante invalide"),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              ),
            ],
          );
        },
      );
    }
  }

  bool validatePass(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    print(value);
    print(regExp.hasMatch(value));
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");
    String nom = storage.getItem('nom');
    String prenom = storage.getItem('prenom');
    String image = storage.getItem('image');
    String email = storage.getItem('email');

    final oldpassword = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Mot de Passe Courante',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (v) {
        if (v.isEmpty) {
          return 'Saisir votre mot de passe courante';
        }
        return null;
      },
      onChanged: (v) {
        setState(() {
          _oldpass = v;
        });
      },
    );
    final newpassword = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Nouvelle Mot de Passe',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (v) {
        if (v.isEmpty) {
          return 'Saisir votre nouvelle mot de passe';
        }
        if (!validatePass(v)) {
          return 'Novelle mot de passe invalide';
        }
        return null;
      },
      onChanged: (v) {
        setState(() {
          _newpass = v;
        });
      },
    );
    final conpassword = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Confirmer Mot de Passe',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (v) {
        if (v.isEmpty) {
          return 'Confirmer votre nouvelle mot de passe';
        }
        return null;
      },
      onChanged: (v) {
        setState(() {
          _conpass = v;
        });
      },
    );
    final modifBtn = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: () {
        // conpassword.onSaved();
        _changeNow();
      },
      padding: EdgeInsets.all(10),
      color: MaterialColors.primary,
      child:
          Text('Modifier Mot de Passe', style: TextStyle(color: Colors.white)),
    );
    return Scaffold(
        extendBodyBehindAppBar: true,
        // resizeToAvoidBottomInset: false,
        appBar: Navbar(
          title: "profil",
          transparent: true,
        ),
        backgroundColor: MaterialColors.bgColorScreen,
        drawer: AddDrower(currentPage: "profile"),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: NetworkImage(host + "/media/" + image),
                        fit: BoxFit.fitWidth)),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.9),
                    ])),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.50,
                ),
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(nom + ' ' + prenom,
                          style: TextStyle(fontSize: 28, color: Colors.white)),
                    ),
                  ],
                ),
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
                      top: MediaQuery.of(context).size.height * 0.58,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 12.0),
                      child: Form(
                        key: _form,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: email,
                              ),
                            ),
                            oldpassword,
                            newpassword,
                            conpassword,
                            modifBtn
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
