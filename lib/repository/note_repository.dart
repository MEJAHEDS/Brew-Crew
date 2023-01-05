import '../dao/note_dao.dart';
import '../models/note.dart';

class NoteRepository {
  final noteDao = NoteDao();

  Future getAllNotes({String? query}) =>
      noteDao.getNotes(columns: [], query: query);

  Future insertNote(Note note) => noteDao.createNote(note);

  Future updateNote(Note note) => noteDao.updateNote(note);

  Future deleteNoteById(int id) => noteDao.deleteNote(id);

  //We are not going to use this in the demo
  Future deleteAllNotes(int id) => noteDao.deleteAllNotes();

  void deleteNoteByCarnetId(int id) {
    noteDao.deleteAllNoteByCarnetId(id);
  }
}
