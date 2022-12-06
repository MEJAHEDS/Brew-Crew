import 'package:fireapp/screens/home/settings_form.dart';
import 'package:fireapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fireapp/services/auth.dart';
import 'package:fireapp/services/database.dart';
import 'package:provider/provider.dart';

import 'package:fireapp/screens/home/brew_list.dart';
import 'package:fireapp/models/brew.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void showSettingsPanel() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      initialData: [],
      value: DataBaseService.withoutUID().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.brown,
              ),
              label: Text("logout"),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.settings),
              label: Text("setings"),
              onPressed: () => showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList()),
      ),
    );
  }
}
