import 'package:fireapp/models/Utilisateur.dart';
import 'package:fireapp/ui/screens/authenticate/authenticate.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'home/home_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //return authenticate widget

    final user = Provider.of<Utilisateur?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return HomePage(
        title: "Home",
      );
    }
  }
}
