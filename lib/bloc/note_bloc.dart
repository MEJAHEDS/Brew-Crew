import 'dart:async';

import '../models/note.dart';

import '../repository/note_repository.dart';

class NoteBloc {
  final _noteRepository = NoteRepository();

  final _notesController = StreamController<List<Note>>.broadcast();

  get notes => _notesController.stream;

  NoteBloc() {
    getNotes(query: '');
  }
  getNotes({required String query}) async {
    _notesController.sink.add(await _noteRepository.getAllNotes());
  }

  addNote(Note note) async {
    await _noteRepository.insertNote(note);
    getNotes(query: '');
  }

  updateNote(Note note) async {
    await _noteRepository.updateNote(note);
    getNotes(query: '');
  }

  deleteNoteById(int id) async {
    _noteRepository.deleteNoteById(id);
    getNotes(query: '');
  }

  dispose() {
    _notesController.close();
  }

  void deleteNoteByCarnetId(int id) {
    _noteRepository.deleteNoteByCarnetId(id);
    getNotes(query: '');
  }
}
