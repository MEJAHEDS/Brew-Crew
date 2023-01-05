import 'dart:async';

import '../models/carnet.dart';

import '../repository/carnet_repository.dart';

class CarnetBloc {
  //Get instance of the Repository
  final _carnetRepository = CarnetRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _carnetController = StreamController<List<Carnet>>.broadcast();

  get carnets => _carnetController.stream;

  CarnetBloc() {
    getCarnets(query: '');
  }

  getCarnets({required String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _carnetController.sink.add(await _carnetRepository.getAllCarnets());
  }

  addCarnet(Carnet carnet) async {
    await _carnetRepository.insertCarnet(carnet);
    getCarnets(query: '');
  }

  updateCarnet(Carnet carnet) async {
    await _carnetRepository.updateCarnet(carnet);
    getCarnets(query: '');
  }

  deleteCarnetById(int id) async {
    _carnetRepository.deleteCarnetById(id);
    getCarnets(query: '');
  }

  dispose() {
    _carnetController.close();
  }
}
