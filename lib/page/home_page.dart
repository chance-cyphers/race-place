import 'package:flutter/material.dart';
import 'package:race_place/api/entrant.dart';
import 'package:race_place/bloc/home_bloc.dart';
import 'package:race_place/page/lobby_page.dart';
import 'package:race_place/page/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = new HomeBloc();
    _homeBloc.whenEntered.listen(_onRacerEntered);
  }

  void _onRace(BuildContext context) {
    _homeBloc.newRacer.add(null);
  }

  void _onRacerEntered(Entrant entrant) {
    var lobbyRoute = new MaterialPageRoute(
        builder: (BuildContext buildContext) => LobbyPage(entrant: entrant));
    Navigator.of(context).push(lobbyRoute);
  }

  void _onLogout(BuildContext context) {
    _homeBloc.logout.add(null);
    var loginRoute = new MaterialPageRoute(
        maintainState: false, builder: (buildContext) => LoginPage());
    Navigator.of(context).pushAndRemoveUntil(loginRoute, (route) => false);
  }

  @override
  void dispose() {
    super.dispose();
    _homeBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _homeBloc.greeting,
      initialData: "",
      builder: (context, snap) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Race place"),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Logout"),
                  onPressed: () {
                    _onLogout(context);
                  },
                ),
                Text(
                  snap.data,
                ),
                RaisedButton(
                  child: Text("Race"),
                  onPressed: () {
                    _onRace(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
