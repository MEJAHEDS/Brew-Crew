import 'package:flutter/material.dart';
import 'package:fireapp/models/brew.dart';

class BrewTitle extends StatelessWidget {
  const BrewTitle({super.key, required this.brew});

  final Brew brew;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/coffee_icon.png'),
              radius: 25.0,
              backgroundColor: Colors.brown[brew.strength],
            ),
            title: Text(brew.name),
            subtitle: Text("Takes ${brew.sugars} sugar(s)"),
          )),
    );
  }
}
