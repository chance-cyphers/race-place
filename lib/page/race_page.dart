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
    return StreamBuilder<Track>(
      stream: _raceBloc.updatedTrack,
      initialData: Track("started", []),
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
                  snap.data.entrants.toString(),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}