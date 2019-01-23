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
        initialData: RaceInfo("Fetching race info...", "", 0, 0),
        builder: (context, snap) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Race place"),
            ),
            body: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 70, top: 50),
                      child: Text(
                        'You are racing now. Run!!!',
                      )),
                  Container(
                      child: Text(snap.data.label1),
                      margin: EdgeInsets.only(bottom: 10, top: 10)),
                  LinearProgressIndicator(value: snap.data.progress1),
                  Container(
                      child: Text(snap.data.label2),
                      margin: EdgeInsets.only(bottom: 10, top: 50)),
                  LinearProgressIndicator(value: snap.data.progress2),
                ],
              ),
            ),
          );
        });
  }
}
