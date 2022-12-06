import 'dart:math';

import 'package:fireapp/models/Utilisateur.dart';
import 'package:fireapp/shared/loading.dart';
import 'package:flutter/material.dart';

import 'package:fireapp/shared/constants.dart';
import 'package:provider/provider.dart';

import '../../services/database.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utilisateur?>(context);

    return StreamBuilder<UtilisateurData>(
        stream: DataBaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UtilisateurData userData = snapshot.data!;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "update your brew settings",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(hintText: "Name"),
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text("$sugar sugars"),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),
                  SizedBox(height: 20.0),
                  //slider
                  Slider(
                    value: (_currentStrength ?? 100).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    inactiveColor: Colors.brown[_currentStrength ?? 100],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) => setState(() {
                      _currentStrength = val.round();
                    }),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pink[400])),
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DataBaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
