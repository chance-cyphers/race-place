import 'package:flutter/material.dart';
import 'package:race_place/api/track.dart';
import 'package:race_place/bloc/race_bloc.dart';

class RacePage extends StatefulWidget {
  final Track track;

  RacePage({key: Key, @required this.track});

  @override
  _RacePageState createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {

  RaceBloc _raceBloc;

  @override
  void initState() {
    super.initState();
    _raceBloc = RaceBloc(widget.track);
  }

  @override
  void deactivate() {
    super.deactivate();
    _raceBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    var emptyEntrantData = TrackEntrant("", 0);
    return StreamBuilder<RaceInfo>(
      stream: _raceBloc.model,
      initialData: RaceInfo(emptyEntrantData, emptyEntrantData),
      builder: (context, snap) {
        var entrant1 = snap.data.entrant1;
        var entrant2 = snap.data.entrant2;

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
                  entrant1.userId + ": " + entrant1.distance.toString() + "km",
                ),
                Text(
                  entrant2.userId + ": " + entrant2.distance.toString() + "km",
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}