import 'package:fireapp/models/note.dart';

import '../services/auth.dart';
import '../services/database_local.dart';

class NoteDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createNote(Note note) async {
    final db = await dbProvider.database;
    var result = db!.insert(NoteTABLE, note.toDatabaseJson());
    print("yes_insert");
    return result;
  }

  Future<List<Note>> getNotes({
    required List<String> columns,
    String? query,
  }) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result = [];

    if (query != null) {
      if (query.isNotEmpty)
        result = await db!.query(NoteTABLE,
            columns: columns, where: '', whereArgs: ["%$query%"]);
    } else {
      String mp = AuthService().currentUser!.uid;
      result = await db!.query(NoteTABLE,
          columns: columns, where: 'uid=?', whereArgs: ["$mp"]);
    }

    List<Note> notes = result.isNotEmpty
        ? result.map((item) => Note.fromDatabaseJson(item)).toList()
        : [];
    return notes;
  }

  Future<int?> updateNote(Note note) async {
    final db = await dbProvider.database;

    var result = await db?.update(NoteTABLE, note.toDatabaseJson(),
        where: "id = ?", whereArgs: [note.id]);
    print("yes_update");
    print(note.id);
    return result;
  }

  Future<int?> deleteNote(int id) async {
    final db = await dbProvider.database;
    var result = await db?.delete(NoteTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future<int?> deleteAllNotes() async {
    final db = await dbProvider.database;
    var result = await db?.delete(NoteTABLE);

    return result;
  }

  void deleteAllNoteByCarnetId(int id) {
    final db = dbProvider.database;
    db.then((value) {
      value?.delete(NoteTABLE, where: 'carnetId = ?', whereArgs: [id]);
    });
  }
}
