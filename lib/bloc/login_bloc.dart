import 'dart:async';

import 'package:race_place/auth/auth.dart';
import 'package:race_place/auth/credentials_keeper.dart';

class LoginInfo {
  String username;
  String password;

  LoginInfo(this.username, this.password);
}

enum LoginStatus { Pending, Success, Failure }

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
    _loginStatusController.onListen = _checkCredentials;
  }

  void _checkCredentials() async {
    var hasCreds = await credentialsKeeper.hasValidCreds();
    if (hasCreds) {
      _loginStatusController.add(LoginStatus.Success);
    }
  }

  void _login(LoginInfo info) {
    _loginStatusController.add(LoginStatus.Pending);
//    var creds = await loginClient.login("test@test.com", "ChuckNorris1");
    loginClient.login(info.username, info.password).then((creds) {
      return credentialsKeeper.save(creds);
    }).then((_) {
      return _loginStatusController.add(LoginStatus.Success);
    }).catchError((err) {
      _loginStatusController.add(LoginStatus.Failure);
    });
  }

  void close() {
    _loginStatusController.close();
    _logInController.close();
  }
}
