import 'dart:async';

import 'package:race_place/auth/auth.dart';
import 'package:race_place/auth/credentials_keeper.dart';

class LoginInfo {
  String username;
  String password;

  LoginInfo(this.username, this.password);
}

class LoginBloc {
  StreamController<void> _loginSuccessController;
  StreamController<LoginInfo> _logInController;

  Stream get loginSuccess => _loginSuccessController.stream;

  Sink<LoginInfo> get login => _logInController.sink;

  LoginBloc() {
    _loginSuccessController = StreamController<void>();
    _logInController = StreamController<LoginInfo>();
    _logInController.stream.listen(_login);
  }

  void _login(LoginInfo info) {
    loginClient.login("test@test.com", "ChuckNorris1").then((creds) {
      return credentialsKeeper.save(creds);
    }).then((_) {
      _loginSuccessController.add({});
    }).catchError((err) {
      print('Error saving credentials: ' + err.toString());
    });
  }

  void close() {
    _loginSuccessController.close();
    _logInController.close();
  }
}
