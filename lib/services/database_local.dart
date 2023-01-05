import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final CarnetTABLE = 'Carnet';
final NoteTABLE = 'Note';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "AnapixNotesDb.db");
    var database = await openDatabase(path,
        version: 7, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute(
        "CREATE TABLE Carnet( id INTEGER , uid TEXT, titre TEXT, creation INTEGER DEFAULT (cast(strftime('%s','now') as int)), modification INTEGER DEFAULT (cast(strftime('%s','now') as int)))");
    await database.execute(
        "CREATE TABLE Note( id INTEGER, carnetId INTEGER , uid TEXT, title TEXT, content TEXT, creation INTEGER DEFAULT (cast(strftime('%s','now') as int)), modification INTEGER DEFAULT (cast(strftime('%s','now') as int)))");
  }
}
