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