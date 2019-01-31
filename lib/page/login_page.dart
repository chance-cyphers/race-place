import 'package:flutter/material.dart';
import 'package:race_place/auth/auth.dart';
import 'package:race_place/auth/credentials_keeper.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  void _login() {
    loginClient.login("test@test.com", "ChuckNorris1").then((creds) {
      credentialsKeeper.save(creds);
    }).catchError((err) {
      print('Error saving credentials: ' + err.toString());
    });
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
