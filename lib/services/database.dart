import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireapp/models/Utilisateur.dart';
import 'package:fireapp/models/brew.dart';

class DataBaseService {
  final db = FirebaseFirestore.instance;
  //collection reference

  final String uid;
  DataBaseService({required this.uid});
  DataBaseService.withoutUID() : uid = "";

  Future updateUserData(String sugars, String name, int strength) async {
    return await db.collection("brews").doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from a snapshot

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc['name'] ?? "",
          sugars: doc['sugars'] ?? "0",
          strength: doc['strength'] ?? 0);
    }).toList();
  }

  //userdata from snapshot

  UtilisateurData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UtilisateurData(
        uid: uid,
        name: snapshot['name'],
        sugars: snapshot['sugars'],
        strength: snapshot['strength']);
  }

  //brew list
  Stream<List<Brew>> get brews {
    return db.collection("brews").snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UtilisateurData> get userData {
    return db
        .collection("brews")
        .doc(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
