import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class RacePage extends StatefulWidget {
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


    this._locationSubscription = location.onLocationChanged().listen((Map<String,double> currentLocation) {
      setState(() {
        _currentLat = currentLocation["latitude"];
        _currentLon = currentLocation["longitude"];
      });
      print(currentLocation["latitude"]);
      print(currentLocation["longitude"]);
      print(currentLocation["accuracy"]);
      print(currentLocation["altitude"]);
      print(currentLocation["speed"]);
      print(currentLocation["speed_accuracy"]); // Will always be 0 on iOS
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
