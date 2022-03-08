import 'package:flutter/material.dart';
import 'package:appflutter/constants/host.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'dart:io';
import 'package:appflutter/api/api.dart';
import 'package:provider/provider.dart';
import 'custom_dialog_box.dart';
import 'package:appflutter/model/Eleves.dart';

String cls = '';

class GestionEleves extends StatefulWidget {
  @override
  _GestionElevesState createState() => _GestionElevesState();
}

class _GestionElevesState extends State<GestionEleves> {
  String _mySelection;
  String classe = '';
  List<String> data = [];

  Future<String> getSWData() async {
    String token;
    LocalStorage storage = LocalStorage('usertoken');
    token = storage.getItem('token');
    final String url = host + '/apis/classes/?token=' + token;
    var res = await http.get(
      Uri.parse(url),
    );
    setState(() {
      data = (jsonDecode(res.body) as List<dynamic>).cast<String>();
      // data = json.decode(res.body) as List;
    });

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    DataTableEleves tt = new DataTableEleves(classe);
    Column widgets = Column(children: []);
    Row dpBtn =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text('Sélectionner la Classe:    '),
      DropdownButton(
        items: data.map((item) {
          return new DropdownMenuItem(
            child: new Text(item),
            value: item.toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            _mySelection = newVal;
            classe = _mySelection;
            tt.setClasse(classe);
            cls = _mySelection;
            // widgets.children.add(tt);
            // widgets.children.removeAt(1);
            widgets.children.insert(1, new DataTableEleves(cls));
            print(widgets.children);
          });
        },
        value: _mySelection,
      ),
    ]);
    widgets.children.add(dpBtn);
    widgets.children.add(new DataTableEleves(cls));
    return Container(width: MediaQuery.of(context).size.height, child: widgets);
  }
}

class DataTableEleves extends StatefulWidget {
  String classe = '';

  DataTableEleves(this.classe);

  void setClasse(classe) {
    this.classe = classe;
  }

  @override
  _DataTableElevesState createState() => _DataTableElevesState(classe);
}

class _DataTableElevesState extends State<DataTableEleves> {
  String classe;
  List<Eleves> data = [];
  _DataTableElevesState(this.classe);

  Future<String> getData() async {
    final url =
        Uri.parse(host + '/apis/classe/?classe=' + cls + '&format=json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var datas = json.decode(response.body) as List;
      setState(() {
        this.data = datas.map<Eleves>((json) => Eleves.fromJson(json)).toList();
      });
    }
    return "Sucess";
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    this.getData();
    return DataTable(
      // columnSpacing: 70,
      
      showCheckboxColumn: false,
      sortColumnIndex: 0,
      sortAscending: true,
      columns: <DataColumn>[
        new DataColumn(
            label: Text('ID'), tooltip: 'ID de l\'élève', numeric: true),
        new DataColumn(
            label: Text('Nom et Prenom'), tooltip: 'Nom de l\'élève'),
        new DataColumn(label: Text('Classe'), tooltip: 'Classe de l\'élève'),
        // new DataColumn(
        //     label: Text('Action'), tooltip: 'Classe de l\'élève'),
      ],
      rows: data
          .map((data) => DataRow(
                  onSelectChanged: (bool selected) {
                    if (selected) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              // title: "Custom Dialog Demo",
                              // descriptions:
                              //     "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                              // text: "Yes",
                              id: data.id,
                            );
                          });
                    }
                  },
                  cells: [
                    DataCell(Text(data.id.toString())),
                    DataCell(Text(data.nom + ' ' + data.prenom)),
                    DataCell(Text(data.classe)),
                    // DataCell(Text(data.parent)),
                    // DataCell(Icon(Icons.person))
                  ]))
          .toList(),
    );
  }
}
