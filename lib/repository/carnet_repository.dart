import '../dao/carnet_dao.dart';
import '../models/carnet.dart';

class CarnetRepository {
  final carnetDao = CarnetDao();

  Future getAllCarnets() => carnetDao.getCarnets(columns: []);

  Future insertCarnet(Carnet carnet) => carnetDao.createCarnet(carnet);

  Future updateCarnet(Carnet carnet) => carnetDao.updateCarnet(carnet);

  Future deleteCarnetById(int id) => carnetDao.deleteCarnet(id);

  //We are not going to use this in the demo
  Future deleteAllCarnets() => carnetDao.deleteAllCarnets();
}
