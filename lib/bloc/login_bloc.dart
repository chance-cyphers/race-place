import 'dart:async';

import 'package:race_place/auth/auth.dart';
import 'package:race_place/auth/credentials_keeper.dart';

class LoginInfo {
  String username;
  String password;

  LoginInfo(this.username, this.password);
}

enum LoginStatus { Pending, Success }

class LoginBloc {
  StreamController<LoginStatus> _loginStatusController;
  StreamController<LoginInfo> _logInController;

  Stream loginStatus;
  Sink<LoginInfo> get login => _logInController.sink;

  LoginBloc() {
    _logInController = StreamController<LoginInfo>();
    _loginStatusController = StreamController<LoginStatus>();
    _logInController.stream.listen(_login);
    loginStatus = _loginStatusController.stream.asBroadcastStream();
  }

  void _login(LoginInfo info) async {
    _loginStatusController.add(LoginStatus.Pending);
    var creds = await loginClient.login("test@test.com", "ChuckNorris1");
    await credentialsKeeper.save(creds);
    _loginStatusController.add(LoginStatus.Success);
  }

  void close() {
    _loginStatusController.close();
    _logInController.close();
  }
}
