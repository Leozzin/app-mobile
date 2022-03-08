import 'package:appflutter/constants/Theme.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/screens/home.dart';

import 'package:appflutter/state/poststate.dart';
import 'package:provider/provider.dart';

import 'oubliemotdepasse.dart';

class LoginScreens extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreensState createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  final _form = GlobalKey<FormState>();
  String _username;
  String _password;

  void _loginNow() async {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    bool islogin = await Provider.of<PostState>(context, listen: false)
        .loginNow(_username, _password);
    if (!islogin) {
      Navigator.of(context).pushReplacementNamed(HomeScreens.routeName);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Somthing is Wrong!Try Again"),
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

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/img/logoccs.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Nom d' 'utlisateur',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (v) {
        if (v.isEmpty) {
          return 'Saisir votre nom d' 'utlisateur';
        }
        return null;
      },
      onSaved: (v) {
        _username = v;
      },
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'mot de passe',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (v) {
        if (v.isEmpty) {
          return 'Saisir votre mot de passe';
        }
        return null;
      },
      onSaved: (v) {
        _password = v;
      },
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _loginNow();
        },
        padding: EdgeInsets.all(12),
        color: MaterialColors.primary,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(Obuliecreens.routeName);
      },
    );
    final ff = Text(
      'Classroom Attendance System',
      style: TextStyle(
          color: MaterialColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 20.0),
      textAlign: TextAlign.center,
    );
    return Scaffold(
      backgroundColor: MaterialColors.bgColorScreen,
      body: Center(
        child: Form(
          key: _form,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 8.0),
              ff,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              loginButton,
              forgotLabel
            ],
          ),
        ),
      ),
    );
  }
}
