import 'package:flutter/material.dart';
import 'package:race_place/auth/auth.dart';
import 'package:race_place/auth/credentials_keeper.dart';
import 'package:race_place/page/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  void _login() {
    loginClient.login("test@test.com", "ChuckNorris1").then((creds) {
      return credentialsKeeper.save(creds);
    }).then((_) {
      _gotoHome();
    }).catchError((err) {
      print('Error saving credentials: ' + err.toString());
    });
  }

  void _gotoHome() {
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(
            maintainState: false,
            builder: (BuildContext buildContext) => HomePage()),
        ModalRoute.withName("/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Race Place"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Login"),
                  onPressed: _login,
                ),
              ]),
        ));
  }
}
