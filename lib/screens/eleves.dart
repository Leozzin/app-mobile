import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/state/poststate.dart';
import 'package:appflutter/widgets/appdrower.dart';
import 'package:provider/provider.dart';
import 'package:appflutter/widgets/navbar.dart';
import 'package:appflutter/constants/Theme.dart';
import 'gestionEleves.dart';

class ElevesScreens extends StatefulWidget {
  static const routeName = '/eleves';

  @override
  _ElevesScreens createState() => _ElevesScreens();
}

class _ElevesScreens extends State<ElevesScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Gestion Eleves',
      ),
      backgroundColor: MaterialColors.bgColorScreen,
      drawer: AddDrower(
        currentPage: "eleves",
      ),
      body: SingleChildScrollView(child: GestionEleves()),
    );
  }
}
