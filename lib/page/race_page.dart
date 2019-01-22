import 'dart:async';

import 'package:flutter/material.dart';
import 'package:race_place/api/location.dart' as loc;
import 'package:race_place/api/race_api_client.dart';
import 'package:race_place/api/track.dart';
import 'package:race_place/bloc/location_source.dart';

class RacePage extends StatefulWidget {
  final Track track;

  RacePage({key: Key, @required this.track});

  @override
  _RacePageState createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {

  LocationEventSource _locEventSource;

  @override
  void initState() {
    super.initState();
    _locEventSource = LocationEventSource();
  }

  @override
  void deactivate() {
    super.deactivate();
    _locEventSource.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Coordinates>(
      stream: _locEventSource.currentLoc,
      initialData: Coordinates(0, 0),
      builder: (context, snap) {
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
                  snap.data.lat.toString() + ", " + snap.data.lon.toString(),
                ),
              ],
            ),
          ),
        );
      }
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

