class Note {
  final String title;
  final int id;
  final int carnetId;
  final String uid;
  final String content;
  final DateTime creation;
  final DateTime modification;

  Note({
    required this.carnetId,
    required this.title,
    required this.id,
    required this.uid,
    required this.content,
    required this.creation,
    required this.modification,
  });

  factory Note.fromDatabaseJson(Map<String, dynamic> data) => Note(
        id: data['id'],
        carnetId: data['carnetId'],
        uid: data['uid'].toString(),
        title: data['title'].toString(),
        content: data['content'].toString(),
        creation: DateTime.now(),
        modification: DateTime.now(),
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "carnetId": this.carnetId,
        "uid": this.uid,
        "title": this.title,
        "content": this.content,
        "creation": this.creation.millisecondsSinceEpoch,
        "modification": this.modification.millisecondsSinceEpoch,
      };
}
