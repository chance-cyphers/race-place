import 'package:flutter/material.dart';
import 'package:race_place/api/entrant.dart';
import 'package:race_place/bloc/lobby_bloc.dart';
import 'package:race_place/page/race_page.dart';
import 'package:race_place/api/track.dart';

class LobbyPage extends StatefulWidget {
  LobbyPage({Key key, @required this.entrant}) : super(key: key);

  final Entrant entrant;

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  LobbyBloc _lobbyBloc;

  @override
  void initState() {
    super.initState();
    _lobbyBloc = LobbyBloc(widget.entrant);
    _lobbyBloc.trackStarted.listen((track) {
      _gotoRace(track);
    });
  }

  void _gotoRace(Track track) {
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(
            maintainState: false,
            builder: (BuildContext buildContext) => RacePage(track: track)),
        ModalRoute.withName("/"));
  }

  @override
  void dispose() {
    super.dispose();
    _lobbyBloc.close();
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
              'Finding match for ${widget.entrant.userId}...',
            ),
          ],
        ),
      ),
    );
  }
}
