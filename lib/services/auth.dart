import 'package:fireapp/models/Utilisateur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireapp/models/Utilisateur.dart';

import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser

  Utilisateur? _userFromFirebaseUser(User? user) {
    return user != null ? Utilisateur(uid: user.uid) : null;
  }

  // auth change user stream

  Stream<Utilisateur?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      //create a new document for the user with the uid
      await DataBaseService(uid: user!.uid)
          .updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
