import 'package:appflutter/constants/Theme.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/screens/home.dart';
import 'package:appflutter/screens/login.dart';
import 'package:appflutter/state/poststate.dart';
import 'package:provider/provider.dart';

class Obuliecreens extends StatefulWidget {
  static const routeName = '/oublie';
  @override
  _Obuliecreens createState() => _Obuliecreens();
}

class _Obuliecreens extends State<Obuliecreens> {
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
        hintText: 'Address Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (v) {
        if (v.isEmpty) {
          return 'Saisir votre address email';
        }
        return null;
      },
      onSaved: (v) {
        _username = v;
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
        child: Text('Envoyer', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Connecter',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
         Navigator.of(context)
                            .pushReplacementNamed(LoginScreens.routeName);
      },
    );
    final ff = Text(
      'Classroom Care System',
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
