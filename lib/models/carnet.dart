class Carnet {
  final int id;
  final String titre;
  final DateTime creation;
  final DateTime modification;
  final String uid;

  Carnet(
      {required this.id,
      required this.uid,
      required this.titre,
      required this.creation,
      required this.modification});

  factory Carnet.fromDatabaseJson(Map<String, dynamic> data) => Carnet(
        id: data['id'],
        uid: data['uid'].toString(),
        titre: data['titre'].toString(),
        creation: DateTime.now(),
        modification: DateTime.now(),
      );
  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "uid": this.uid,
        "titre": this.titre,
        "creation": this.creation.millisecondsSinceEpoch,
        "modification": this.modification.millisecondsSinceEpoch,
      };
}
