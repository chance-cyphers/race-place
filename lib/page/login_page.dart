import 'package:flutter/material.dart';
import 'package:race_place/bloc/login_bloc.dart';
import 'package:race_place/page/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
    _loginBloc.loginStatus.listen((status) {
      if (status == LoginStatus.Success) {
        _gotoHome();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.close();
  }

  void _login() {
    var username = _usernameController.text;
    var password = _passwordController.text;
    _loginBloc.login.add(LoginInfo(username, password));
  }

  void _gotoHome() {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
            maintainState: false,
            builder: (BuildContext buildContext) => HomePage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var progressBody = Center(child: CircularProgressIndicator());

    return StreamBuilder<LoginStatus>(
        stream: _loginBloc.loginStatus,
        builder: (context, snap) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Race Place"),
              ),
              body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: snap.data == LoginStatus.Pending
                      ? progressBody
                      : _body(snap.data)));
        });
  }

  Widget _body(LoginStatus status) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(hintText: "Username"),
            ),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(hintText: "Password"),
            ),
            Text((status == LoginStatus.Failure ? 'Sign in harder' : '')),
            RaisedButton(
              child: Text("Login"),
              onPressed: _login,
            ),
          ]),
    );
  }
}
