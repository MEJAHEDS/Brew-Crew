import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Utilisateur.dart';
import '../models/carnet.dart';

import '../repository/carnet_repository.dart';

import '../bloc/carnet_bloc.dart';

class DataBaseService {
  final db = FirebaseFirestore.instance;
  //collection reference

  final String uid;
  DataBaseService({required this.uid});
  DataBaseService.withoutUID() : uid = "";

  //update user data

  Future updateUserData(List<Carnet> carnet) async {
    List<Carnet> data = [];
    for (var i = 0; i < carnet.length; i++) {
      db
          .collection("All date ")
          .doc(uid)
          .collection("Mes carnets")
          .doc(" ${carnet[i].id}")
          .set({
        'id': carnet[i].id,
        'uid': carnet[i].uid,
        'creation': carnet[i].creation,
        'modification': carnet[i].modification,
        'titre': carnet[i].titre,
      });
    }
  }

  //brew list from a snapshot

  List<Carnet> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Carnet(
          id: doc[''] ?? "",
          uid: '',
          creation: DateTime.now(),
          modification: DateTime.now(),
          titre: '');
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
  Stream<List<Carnet>> get brews {
    return db.collection("Mes_Carnets").snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UtilisateurData> get userData {
    return db
        .collection("Mes_Carnets")
        .doc(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
