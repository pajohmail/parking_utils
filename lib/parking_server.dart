//Sätt upp en Shelf-server med lämpliga routes för varje entitetstyp f och metoder rån klassen watchtower
// Implementera route-hanterare för CRUD-operationer:
//
// GET (alla och efter ID)
// POST (skapa)
// PUT (uppdatera)
// DELETE
// Skapa ObjectBox-repositories för varje entitetstyp:
//
// Implementera CRUD-operationer med ObjectBox.
// Sätt upp felhantering och lämpliga HTTP-statuskoder för svar.

import 'dart:convert';
import 'dart:io';
import 'package:parking_utils/watch_tower.dart';
import 'package:shelf_router/shelf_router.dart';
import 'watch_tower.dart';
import 'parking_time.dart';
import 'parking_space.dart';
class ParkingServer{
  final Router _router = Router();
  final _watchtower = WatchTower();

  ParkingServer(){
    _router
      ..add('GET', '/parkingtimes', _getAllParkingTimes)
      ..add('GET', '/parkingtimes/:id', _getParkingTimeById)
      ..add('POST', '/parkingtimes', _addParkingTime)
      ..add('PUT', '/parkingtimes/:id', _updateParkingTime)
      ..add('DELETE', '/parkingtimes/:id', _deleteParkingTime)
      ..add('GET', '/parkingspaces', _getAllParkingSpaces)
      ..add('GET', '/parkingspaces/:id', _getParkingSpaceById)
      ..add('POST', '/parkingspaces', _addParkingSpace)
      ..add('PUT', '/parkingspaces/:id', _updateParkingSpace)
      ..add('DELETE', '/parkingspaces/:id', _deleteParkingSpace)
      ..add('GET', '/persons', _getAllPersons)
      ..add('GET', '/persons/:id', _getPersonById)
      ..add('POST', '/persons', _addPerson)
      ..add('PUT', '/persons/:id', _updatePerson)
      ..add('DELETE', '/persons/:id', _deletePerson)
      ..add('GET', '/vehicles', _getAllVehicles)
      ..add('GET', '/vehicles/:id', _getVehicleById)
      ..add('POST', '/vehicles', _addVehicle)
      ..add('PUT', '/vehicles/:id', _updateVehicle)
      ..add('DELETE', '/vehicles/:id', _deleteVehicle);
  }

  Future<void> _getAllParkingTimes(HttpRequest request) async {
    final parkingTimes = _watchtower.getAllTimes();
    request.response
      ..write(jsonEncode(parkingTimes))
      ..close();
  }

  Future<void> _getParkingTimeById(HttpRequest request) async {
    final id = int.parse(request.uri.pathSegments.last);
    final parkingTime = _watchtower.getTimeById(id);
    if (parkingTime != null) {
      request.response
        ..write(jsonEncode(parkingTime))
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Parking time with ID $id not found.')
        ..close();
    }
  }

  Future<void> _addParkingTime(HttpRequest request) async {
    final jsonString = await utf8.decoder.bind(request).join();
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final parkingTime = ParkingTime(
      endTime: DateTime.parse(data['endTime']),
      personID: data['personID'],
      spaceID: data['spaceID'],
      vehicleID: data['vehicleID'],
    );
    _watchtower.addTime(parkingTime);
    request.response
      ..statusCode = HttpStatus.created
      ..write(jsonEncode(parkingTime))
      ..close();
  }

  Future<void> _updateParkingTime(HttpRequest request) async {
    final id = int.parse(request.uri.pathSegments.last);
    final jsonString = await utf8.decoder.bind(request).join();
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final parkingTime = _watchtower.getTimeById(id);
    if (parkingTime != null) {
      parkingTime.endTime = DateTime.parse(data['endTime']);
      parkingTime.personID = data['personID'];
      parkingTime.spaceID = data['spaceID'];
      parkingTime.vehicleID = data['vehicleID'];
      _watchtower.updateTime(parkingTime);
      request.response
        ..write(jsonEncode(parkingTime))
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Parking time with ID $id not found.')
        ..close();
    }
  }
  Future <void> _deleteParkingTime(HttpRequest request) async {
    final id = int.parse(request.uri.pathSegments.last);
    final parkingTime = _watchtower.getTimeById(id);
    if (parkingTime != null) {
      _watchtower.deleteTime(parkingTime);
      request.response
        ..write(jsonEncode(parkingTime))
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Parking time with ID $id not found.')
        ..close();
    }
  }

  Future<void> _getAllParkingSpaces(HttpRequest request) async {
    final parkingSpaces = _watchtower.getAllSpaces();
    request.response
      ..write(jsonEncode(parkingSpaces))
      ..close();
  }

  Future<void> _getParkingSpaceById(HttpRequest request) async {
    final id = int.parse(request.uri.pathSegments.last);
    final parkingSpace = _watchtower.getSpaceById(id);
    if (parkingSpace != null) {
      request.response
        ..write(jsonEncode(parkingSpace))
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Parking space with ID $id not found.')
        ..close();
    }
  }

  Future<void> _addParkingSpace(HttpRequest request) async {
    final jsonString = await utf8.decoder.bind(request).join();
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final parkingSpace = ParkingSpace(
      isOccupied: data['isOccupied'],
      location: data['location'],
      type: data['type'],
    );
    _watchtower.addSpace(parkingSpace);
    request.response
      ..statusCode = HttpStatus.created
      ..write(jsonEncode(parkingSpace))
      ..close();
  }

  Future<void> _updateParkingSpace(HttpRequest request) async {
    final id = int.parse(request.uri.pathSegments.last);
    final jsonString = await utf8.decoder.bind(request).join();
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final parkingSpace = _watchtower.getSpaceById(id);
    if (parkingSpace != null) {
      parkingSpace.isOccupied = data['isOccupied'];
      parkingSpace.location = data['location'];
      parkingSpace.type = data['type'];
      _watchtower.addSpace(parkingSpace);
      request.response
        ..write(jsonEncode(parkingSpace))
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Parking space with ID $id not found.')
        ..close();
    }
  }

  Future<void> _deleteParkingSpace(HttpRequest request) async {
    final id = int.parse(request.uri.pathSegments.last);
    final parkingSpace = _watchtower.getSpaceById(id);
    if (parkingSpace != null) {
      _watchtower.deleteSpace(parkingSpace);
      request.response
        ..write(jsonEncode(parkingSpace))
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Parking space with ID $id not found.')
        ..close();
    }
  }

  Future<void> _getAllPersons(HttpRequest request) async {
    final persons = _watchtower.getAllPersons();
    request.response
      ..write(jsonEncode(persons))
      ..close();
  }

  Future<void> _getPersonById(HttpRequest request) async {
    final id = int.parse(request.uri.pathSegments.last);
    final person = _watchtower.getPersonById(id);
    if (person != null) {
      request.response
        ..write(jsonEncode(person))
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Person with ID $id not found.')
        ..close();
    }
  }
  Future <void> _addPerson(HttpRequest request) async {
    final jsonString = await utf8.decoder.bind(request).join();
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final person = Person(
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
    );
    _watchtower.addPerson(person);
    request.response
      ..statusCode = HttpStatus.created
      ..write(jsonEncode(person))
      ..close();
  }

  Future<void> _updatePerson(HttpRequest request) async {
    final id = int.parse(request.uri.pathSegments.last);
    final jsonString = await utf8.decoder.bind(request).join();
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final person = _watchtower.getPersonById(id);
    if (person != null) {
      person.name = data['name'];
      person.email = data['email'];
      person.phone = data['phone'];
      _watchtower.updatePerson(person);
      request.response
        ..write(jsonEncode(person))
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Person with ID $id not found.')
        ..close();
    }
}
  Future <void> _deletePerson(HttpRequest request) async {
    final id = int.parse(request.uri.pathSegments.last);
    final person = _watchtower.getPersonById(id);
    if (person != null) {
      _watchtower.deletePerson(person);
      request.response
        ..write(jsonEncode(person))
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Person with ID $id not found.')
        ..close();
    }
  }
  Future<void> _getAllVehicles(HttpRequest request) async {
    final vehicles = _watchtower.getAllVehicles();
    request.response
      ..write(jsonEncode(vehicles))
      ..close();
  }

  Future<void> _getVehicleById(HttpRequest request) async {
    final id = int.parse(request.uri.pathSegments.last);
    final vehicle = _watchtower.getVehicleById(id);
    if (vehicle != null) {
      request.response
        ..write(jsonEncode(vehicle))
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Vehicle with ID $id not found.')
        ..close();
    }

    Future <void> _addVehicle(HttpRequest request) async {
      final jsonString = await utf8.decoder.bind(request).join();
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      final vehicle = Vehicle(
        numberPlate: data['numberPlate'],
        vehicleType: data['vehicleType'],
      );
      _watchtower.addVehicle(vehicle);
      request.response
        ..statusCode = HttpStatus.created
        ..write(jsonEncode(vehicle))
        ..close();
    }

    Future<void> _updateVehicle(HttpRequest request) async {
      final id = int.parse(request.uri.pathSegments.last);
      final jsonString = await utf8.decoder.bind(request).join();
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      final vehicle = _watchtower.getVehicleById(id);
      if (vehicle != null) {
        vehicle. = data['numberPlate'];
        vehicle.vehicleType = data['vehicleType'];
        _watchtower.addVehicle(vehicle);
        request.response
          ..write(jsonEncode(vehicle))
          ..close();
      } else {
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Vehicle with ID $id not found.')
          ..close();
      }
    }

    Future <void> _deleteVehicle(HttpRequest request) async {
      final id = int.parse(request.uri.pathSegments.last);
      final vehicle = _watchtower.getVehicleById(id);
      if (vehicle != null) {
        _watchtower.deleteVehicle(vehicle);
        request.response
          ..write(jsonEncode(vehicle))
          ..close();
      } else {
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Vehicle with ID $id not found.')
          ..close();
      }
    }
  Future <void> start({int port = 8080}) async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
    print('Server listening on port ${server.port}...');
    await for (final request in server) {
      _router.route(request);
    }
  }

   Future <void> stop() async {
     await server.close(force: true);
   }

  Future <void> restart({int port = 8080}) async {
    await stop();
    await start(port: port);
  }

}