import 'dart:async';

import 'package:location/location.dart';

class LocationEventSource {
  StreamController<Coordinates> _currentLocController;
  StreamSubscription<Map<String, double>> _locationSubscription;

  Stream<Coordinates> get currentLoc => _currentLocController.stream;

  LocationEventSource() {
    _currentLocController = StreamController<Coordinates>();
    _currentLocController.onListen = _listenForLocation;
  }

  void _listenForLocation() {
    var location = new Location();
    this._locationSubscription = location
        .onLocationChanged()
        .listen((Map<String, double> currentLocation) {
      var currentLat = currentLocation["latitude"];
      var currentLon = currentLocation["longitude"];
      _currentLocController.add(Coordinates(currentLat, currentLon));
    });
  }

  void close() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    _currentLocController.close();
  }
}

class Coordinates {
  double lat;
  double lon;

  Coordinates(this.lat, this.lon);
}
