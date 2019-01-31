import 'package:flutter/material.dart';
import 'package:race_place/auth/auth.dart';
import 'package:race_place/auth/credentials_keeper.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  String someText = "what's up, and stuff";

  void _login() {
    loginClient.login("test@test.com", "ChuckNorris1").then((creds) {
      credentialsKeeper.save(creds);
    }).catchError((err) {
      print('Error saving credentials: ' + err.toString());
    });
  }

  void _clear() {
    credentialsKeeper.clear();
  }

  void _get() {
    credentialsKeeper.getCredentials().then((accessToke) {
      setState(() {
        someText =
            "access_token: " + (accessToke == null ? "null" : accessToke);
      });
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
                Text(someText),
                RaisedButton(
                  child: Text("Login"),
                  onPressed: _login,
                ),
                RaisedButton(
                  child: Text("clear"),
                  onPressed: _clear,
                ),
                RaisedButton(
                  child: Text("get"),
                  onPressed: _get,
                ),
              ]),
        ));
  }
}
