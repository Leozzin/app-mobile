import 'dart:ui';
import 'package:appflutter/api/api.dart';
import 'package:provider/provider.dart';

import 'package:appflutter/constants/constants.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appflutter/model/Eleves.dart';

class CustomDialogBox extends StatefulWidget {
  // final String title, descriptions, text;
  // final Image img;
  final int id;

  const CustomDialogBox(
      {Key key, this.id})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return ChangeNotifierProvider<EleveProvider>(
      create: (context) => EleveProvider(),
      child: Consumer<EleveProvider>(
        builder: (context, provider, child) {
          if (provider.data == null) {
            provider.getData(context, widget.id);
            print(provider.data);
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // },
          return Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: Constants.padding,
                    top: Constants.avatarRadius + Constants.padding,
                    right: Constants.padding,
                    bottom: Constants.padding),
                margin: EdgeInsets.only(top: Constants.avatarRadius),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Constants.padding),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 10),
                          blurRadius: 10),
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      provider.data.nom + ' ' + provider.data.prenom,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '- Classe:                      ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              // textAlign: TextAlign.center,
                            ),
                            Text(
                              provider.data.classe,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '- Date de Naissance: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              // textAlign: TextAlign.center,
                            ),
                            Text(
                              provider.data.dateNaissance,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '- Prenom Parent:       ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              // textAlign: TextAlign.center,
                            ),
                            Text(
                              provider.data.parent,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '- Email Parent:   ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              // textAlign: TextAlign.center,
                            ),
                            Text(
                              provider.data.emailParent,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '- Tel Parent:       ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              // textAlign: TextAlign.center,
                            ),
                            Text(
                              provider.data.phoneParent,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '- Adresse:  ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              // textAlign: TextAlign.center,
                            ),
                            Text(
                              provider.data.address,
                            ),
                          ],
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    // SizedBox(
                    //   height: 22,
                    // ),
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: FlatButton(
                    //       onPressed: () {
                    //         Navigator.of(context).pop();
                    //       },
                    //       child: Text(
                    //         widget.text,
                    //         style: TextStyle(fontSize: 18),
                    //       )),
                    // ),
                  ],
                ),
              ),
              Positioned(
                left: Constants.padding,
                right: Constants.padding,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: Constants.avatarRadius,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Constants.avatarRadius)),
                      child: Image.network(
                          // "https://static.wikia.nocookie.net/haikyuu/images/d/d2/Hinata_s4-e1-4.png/revision/latest/smart/width/250/height/250?cb=20200506183149"
                          provider.data.image)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
