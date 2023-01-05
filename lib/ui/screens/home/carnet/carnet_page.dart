import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../bloc/note_bloc.dart';

import '../../../../models/carnet.dart';
import '../../../../models/note.dart';

import '../../../../repository/note_repository.dart';
import '../../../../services/auth.dart';
import 'note_detail.dart';

int maxid = 0;

class CarnetPage extends StatelessWidget {
  CarnetPage({Key? key, required this.carnet, required this.title})
      : super(key: key);

  final NoteBloc noteBloc = NoteBloc();
  final Carnet carnet;
  final String title;

  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${carnet.titre}"),
          backgroundColor: Colors.green[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.sync, color: Colors.black),
              label: Text(
                "sync",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                //create a new document for the user with the uid
                final User? user = FirebaseAuth.instance.currentUser;

                NoteRepository noteRepository = NoteRepository();
                List<Note> note = await noteRepository.getAllNotes(
                    query: 'where carnet_id = ${carnet.id}  ');
              },
            ),
          ],
        ),
        body: SafeArea(
            child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo-anapix-medical-1.png'),
                      ),
                    ),
                    child: getNotesWidget(carnet.id)))),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            elevation: 5.0,
            onPressed: () {
              _showAddTodoSheet(context);
            },
            backgroundColor: Colors.green[400],
            child: Icon(
              Icons.add,
              size: 32,
              color: Colors.indigoAccent,
            ),
          ),
        ));
  }

  void _showAddTodoSheet(BuildContext context) {
    final AuthService _auth = AuthService();
    final _todoTitleFormController = TextEditingController();
    final _todoContentFormController = TextEditingController();
    int maxid = 1;
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: new Container(
              color: Colors.transparent,
              child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _todoTitleFormController,
                                  textInputAction: TextInputAction.newline,
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                  decoration: const InputDecoration(
                                      hintText: 'title',
                                      labelText: 'titre',
                                      labelStyle: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500)),
                                ),
                                TextFormField(
                                  controller: _todoContentFormController,
                                  maxLines: 6,
                                  decoration: const InputDecoration(
                                      hintText: 'content',
                                      labelText: 'contenu',
                                      labelStyle: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue[400],
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.note_add_sharp,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  NoteRepository noteRepository =
                                      NoteRepository();
                                  List<Note> notes =
                                      await noteRepository.getAllNotes();
                                  int maxid = notes.length;
                                  if (maxid == 0) {
                                    maxid = 1;
                                  } else {
                                    maxid = notes.last.id + 1;
                                  }
                                  final newNote = Note(
                                      id: maxid,
                                      title: _todoTitleFormController.text
                                          .toString(),
                                      carnetId: carnet.id,
                                      content: _todoContentFormController.text
                                          .toString(),
                                      creation: DateTime.now(),
                                      modification: DateTime.now(),
                                      uid: _auth.currentUser!.uid);

                                  if (newNote.title.isNotEmpty) {
                                    /*Create new Todo object and make sure
                                    the Todo description is not empty,
                                    because what's the point of saving empty
                                    Todo
                                    */
                                    noteBloc.addNote(newNote);
                                    print(newNote.content);

                                    //dismisses the bottomsheet
                                    Navigator.pop(context);
                                  }
                                  print("add note");
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _showUpdTodoSheet(BuildContext context, Note note) {
    final AuthService _auth = AuthService();
    final _todoTitleFormController = TextEditingController();
    final _todoContentFormController = TextEditingController();
    _todoTitleFormController.text = note.title;
    _todoContentFormController.text = note.content;
    String content = note.content;
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: new Container(
              color: Colors.transparent,
              child: new Container(
                height: 430,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _todoTitleFormController,
                                  textInputAction: TextInputAction.newline,
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                  decoration: const InputDecoration(
                                      hintText: 'Titre',
                                      labelText: 'update Titre',
                                      labelStyle: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500)),
                                ),
                                TextFormField(
                                  controller: _todoContentFormController,
                                  maxLines: 6,
                                  decoration: const InputDecoration(
                                      hintText: "Contenu",
                                      labelText: "update contenu",
                                      labelStyle: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.save,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  NoteRepository noteRepository =
                                      NoteRepository();

                                  final newNote = Note(
                                      id: note.id,
                                      title: _todoTitleFormController.text
                                          .toString(),
                                      carnetId: note.carnetId,
                                      content: _todoContentFormController.text
                                          .toString(),
                                      creation: note.creation,
                                      modification: DateTime.now(),
                                      uid: _auth.currentUser!.uid);

                                  if (newNote.title.isNotEmpty) {
                                    noteBloc.updateNote(newNote);

                                    //dismisses the bottomsheet
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget getNotesWidget(int carnetId) {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */

    return StreamBuilder(
      stream: noteBloc.notes,
      builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
        return getTodoCardWidget(snapshot, carnetId);
      },
    );
  }

  Widget getTodoCardWidget(AsyncSnapshot<List<Note>> snapshot, int carnetId) {
    if (snapshot.hasData) {
      var maxid = snapshot.data!.length;
      if (maxid == 0) {
        maxid = 1;
      }

      return snapshot.data?.length != 0
          ? ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, itemPosition) {
                Note note = snapshot.data![itemPosition];
                final Widget dismissibleCard = new Dismissible(
                  background: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Deleting",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                  onDismissed: (direction) {
                    noteBloc.deleteNoteById(note.id);
                  },
                  direction: _dismissDirection,
                  key: new ObjectKey(note),
                  child: Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Card(
                            margin: EdgeInsets.all(15),
                            child: TextButton.icon(
                              icon: Icon(Icons.note, color: Colors.purple),
                              label: Text(
                                "${note.title}",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NoteDetail(note: note),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showUpdTodoSheet(context, note);
                        },
                      ),
                    ),
                  ),
                );
                return dismissibleCard;
              },
            )
          : Container(
              child: Center(
              child: noTodoMessageWidget(),
            ));
    } else {
      return Center(
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    noteBloc.getNotes(
      query: '',
    );
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading..",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget noTodoMessageWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Text(
          "Start adding Note..",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              backgroundColor: Colors.white),
        ),
      ),
    );
  }

  dispose() {
    noteBloc.dispose();
  }
}
