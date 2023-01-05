import 'dart:async';

import 'package:fireapp/models/carnet.dart';
import 'package:fireapp/services/auth.dart';

import '../services/database_local.dart';

class CarnetDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createCarnet(Carnet carnet) async {
    final db = await dbProvider.database;
    var result = db!.insert(CarnetTABLE, carnet.toDatabaseJson());
    print("yes_insert");
    return result;
  }

  Future<List<Carnet>> getCarnets(
      {required List<String> columns, String? query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result = [];

    if (query != null) {
      if (query.isNotEmpty)
        result = await db!.query(CarnetTABLE,
            columns: columns, where: 'titre LIKE ?', whereArgs: ["%$query%"]);
    } else {
      String mp = AuthService().currentUser!.uid;
      result = await db!.query(CarnetTABLE,
          columns: columns, where: 'uid=?', whereArgs: ["$mp"]);
    }

    List<Carnet> carnets = result.isNotEmpty
        ? result.map((item) => Carnet.fromDatabaseJson(item)).toList()
        : [];
    return carnets;
  }

  //Update Todo record
  Future<int?> updateCarnet(Carnet carnet) async {
    final db = await dbProvider.database;

    var result = await db?.update(CarnetTABLE, carnet.toDatabaseJson(),
        where: "id = ?", whereArgs: [carnet.id]);
    print("yes_update");
    print(carnet.id);
    return result;
  }

  //Delete Todo records
  Future<int?> deleteCarnet(int id) async {
    final db = await dbProvider.database;
    var result =
        await db?.delete(CarnetTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllCarnets() async {
    final db = await dbProvider.database;
    var result = await db!.delete(
      CarnetTABLE,
    );

    return result;
  }

  getMaxId(int maxId) {
    return maxId++;
  }
}
