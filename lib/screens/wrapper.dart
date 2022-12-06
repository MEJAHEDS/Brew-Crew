import 'package:fireapp/models/Utilisateur.dart';
import 'package:fireapp/screens/authenticate/authenticate.dart';
import 'package:fireapp/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //return authenticate widget

    final user = Provider.of<Utilisateur?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
