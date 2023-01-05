import 'dart:ffi';

import 'package:fireapp/models/carnet.dart';
import 'package:fireapp/repository/note_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../dao/carnet_dao.dart';
import '../../../bloc/carnet_bloc.dart';
import '../../../models/Utilisateur.dart';
import '../../../repository/carnet_repository.dart';
import '../../../services/auth.dart';
import '../../../services/database.dart';
import 'carnet/carnet_page.dart';

int maxid = 0;

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  //We load our Todo BLoC that is used to get
  //the stream of Todo for StreamBuilder
  final CarnetBloc carnetBloc = CarnetBloc();

  final String title;

  //Allows Todo card to be dismissable horizontally
  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[400],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.blue,
                    ),
                    Center(
                        child:
                            Text(' mail : ${AuthService().currentUser.email}')),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.green[00],
                ),
              ),
              ListTile(
                title: Text('Comprendre le fonctionnement de l\'application'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('contactez-nous'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              Container(
                padding: EdgeInsets.fromLTRB(100, 520, 30, 0),
                child: ListTile(
                  title: Text(
                    '@Mejahed Soufiane',
                    style: TextStyle(color: Colors.blue, fontSize: 10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Anapix Notes"),
          backgroundColor: Colors.green[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: Text(
                "logout",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.sync, color: Colors.black),
              label: Text(
                "sync",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                //create a new document for the user with the uid
                final User? user = FirebaseAuth.instance.currentUser;

                CarnetRepository carnetRepository = CarnetRepository();
                List<Carnet> carnet = await carnetRepository.getAllCarnets();
                await DataBaseService(uid: user!.uid).updateUserData(carnet);
                print("synced ${carnet.length}");
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
                    //This is where the magic starts
                    child: getTodosWidget()))),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            elevation: 5.0,
            onPressed: () {
              _showAddTodoSheet(context);
            },
            backgroundColor: Colors.white,
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
    final _todoDescriptionFormController = TextEditingController();
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
                height: 230,
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
                            child: TextFormField(
                              controller: _todoDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Noueau carnet',
                                  labelText: 'Carnet',
                                  labelStyle: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontWeight: FontWeight.w500)),
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
                                  CarnetRepository carnetRepository =
                                      CarnetRepository();
                                  List<Carnet> carnetss =
                                      await carnetRepository.getAllCarnets();
                                  int maxid = carnetss.length;
                                  if (maxid == 0) {
                                    maxid = 1;
                                  } else {
                                    maxid = carnetss.last.id + 1;
                                  }
                                  final newCarnet = Carnet(
                                    titre: _todoDescriptionFormController
                                        .value.text,
                                    creation: DateTime.now(),
                                    modification: DateTime.now(),
                                    id: maxid,
                                    uid: '${_auth.currentUser.uid}',
                                  );

                                  if (newCarnet.titre.isNotEmpty) {
                                    /*Create new Todo object and make sure
                                    the Todo description is not empty,
                                    because what's the point of saving empty
                                    Todo
                                    */
                                    carnetBloc.addCarnet(newCarnet);
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

  void _showUpdTodoSheet(BuildContext context, Carnet carnet) {
    final AuthService _auth = AuthService();
    final _todoDescriptionFormController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: new Container(
              color: Colors.transparent,
              child: new Container(
                height: 230,
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
                            child: TextFormField(
                              controller: _todoDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'update carnet',
                                  labelText: 'Carnet',
                                  labelStyle: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontWeight: FontWeight.w500)),
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
                                  CarnetRepository carnetRepository =
                                      CarnetRepository();

                                  final newCarnet = Carnet(
                                    titre: _todoDescriptionFormController
                                        .value.text,
                                    creation: carnet.creation,
                                    modification: DateTime.now(),
                                    id: carnet.id,
                                    uid: carnet.uid,
                                  );

                                  if (newCarnet.titre.isNotEmpty) {
                                    carnetBloc.updateCarnet(newCarnet);

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

  Widget getTodosWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: carnetBloc.carnets,
      builder: (BuildContext context, AsyncSnapshot<List<Carnet>> snapshot) {
        return getTodoCardWidget(snapshot);
      },
    );
  }

  Widget getTodoCardWidget(AsyncSnapshot<List<Carnet>> snapshot) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshot.hasData) {
      var maxid = snapshot.data!.length;
      if (maxid == 0) {
        maxid = 1;
      }
      return snapshot.data?.length != 0
          ? ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, itemPosition) {
                Carnet carnet = snapshot.data![itemPosition];
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
                    /*The magic
                    delete Todo item by ID whenever
                    the card is dismissed
                    */

                    carnetBloc.deleteCarnetById(carnet.id);
                    NoteRepository noteRepository = NoteRepository();
                    noteRepository.deleteAllNotes(carnet.id);
                  },
                  direction: _dismissDirection,
                  key: new ObjectKey(carnet),
                  child: Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Card(
                            margin: EdgeInsets.all(15),
                            child: TextButton.icon(
                              icon: Icon(Icons.book, color: Colors.black),
                              label: Text(
                                "${carnet.titre}",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CarnetPage(
                                      carnet: carnet,
                                      title: 'Carnet',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                  "Créer le : ${carnet.creation.month}/${carnet.creation.day}/${carnet.creation.year}"),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showUpdTodoSheet(context, carnet);
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
              //this is used whenever there 0 Todo
              //in the data base
              child: noTodoMessageWidget(),
            ));
    } else {
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    //pull todos again
    carnetBloc.getCarnets(query: '');
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
          "Start adding Carnet..",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              backgroundColor: Colors.white),
        ),
      ),
    );
  }

  dispose() {
    /*close the stream in order
    to avoid memory leaks
    */
    carnetBloc.dispose();
  }
}
