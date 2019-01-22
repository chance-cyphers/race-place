import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:race_place/api/race_api_client.dart';
import 'package:race_place/api/track.dart';
import 'package:race_place/api/location.dart' as loc;

class RacePage extends StatefulWidget {
  final Track track;

  RacePage({key: Key, @required this.track});

  @override
  _RacePageState createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {
  StreamSubscription<Map<String, double>> _locationSubscription;
  double _currentLat = 0.0;
  double _currentLon = 0.0;

  @override
  void initState() {
    super.initState();

    var location = new Location();
    this._locationSubscription = location
        .onLocationChanged()
        .listen((Map<String, double> currentLocation) {
      setState(() {
        _currentLat = currentLocation["latitude"];
        _currentLon = currentLocation["longitude"];
      });
      print(currentLocation["latitude"].toString() +
          ", " +
          currentLocation["longitude"].toString());
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    _locationSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Race place"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'You are racing now. Just so you know.',
            ),
            Text(
              _currentLat.toString() + ", " + _currentLon.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class RaceBloc {
  StreamController<Coordinates> _updatedLocController;
  StreamSubscription<Coordinates> _locationSubscription;
  LocationEventSource _locEventSource;
  Track _track;

  Stream<Coordinates> get updatedLoc => _updatedLocController.stream;

  RaceBloc(this._track) {
    _updatedLocController.onListen = _startLocUpdates;
    _locEventSource = LocationEventSource();
  }

  void _startLocUpdates() {
    _locationSubscription = _locEventSource.currentLoc.listen((coords) {
      var currentLoc = loc.Location(213, coords.lat, coords.lon);
      raceApiClient
          .updateLocation(_track.links.locationUpdate, currentLoc)
          .then((loc) {
        print("loc update working...");
        _updatedLocController.add(Coordinates(loc.lat, loc.lon));
      }).catchError((err) {
        print("A BIG OLE ERROR: " + err);
      });
    });
  }

  void close() {
    _locEventSource.close();
    _updatedLocController.close();
    _locationSubscription.cancel();
  }
}

class LocationEventSource {
  StreamController<Coordinates> _currentLocController;
  StreamSubscription<Map<String, double>> _locationSubscription;

  Stream<Coordinates> get currentLoc => _currentLocController.stream;

  LocationEventSource() {
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
    _locationSubscription.cancel();
    _currentLocController.close();
  }
}

class Coordinates {
  double lat;
  double lon;

  Coordinates(this.lat, this.lon);
}
