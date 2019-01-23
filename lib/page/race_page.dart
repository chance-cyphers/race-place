import 'package:flutter/material.dart';
import 'package:race_place/api/track.dart';
import 'package:race_place/bloc/race_bloc.dart';
import 'package:race_place/page/finish_screen.dart';

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
    _raceBloc.winner.listen(_gotoFinish);
  }

  void _gotoFinish(String winner) {
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(
            maintainState: false,
            builder: (BuildContext buildContext) =>
                FinishScreen(winner: winner)),
        ModalRoute.withName("/"));
  }

  @override
  void deactivate() {
    super.deactivate();
    _raceBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RaceInfo>(
        stream: _raceBloc.model,
        initialData: RaceInfo("", "", 0, 0),
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
                    'You are racing now. Run!!!',
                  ),
                  Text(snap.data.label1),
                  LinearProgressIndicator(value: snap.data.progress1),
                  Text(snap.data.label2),
                  LinearProgressIndicator(value: snap.data.progress2),
                ],
              ),
            ),
          );
        });
  }
}
