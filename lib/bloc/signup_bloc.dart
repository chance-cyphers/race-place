import 'dart:async';

import 'package:race_place/auth/auth.dart';
import 'package:race_place/auth/credentials_keeper.dart';

class SignupInfo {
  String username;
  String password;
  String passwordConf;

  SignupInfo(this.username, this.password, this.passwordConf);
}

class SignupBloc {
  StreamController<SignupInfo> _signupController;
  StreamController<String> _errorController;
  StreamController _userCreatedController;

  Sink<SignupInfo> get signup => _signupController.sink;

  Stream get whenSuccess => _userCreatedController.stream;
  Stream<String> get whenError => _errorController.stream;

  SignupBloc() {
    _signupController = StreamController();
    _userCreatedController = StreamController();
    _errorController = StreamController();

    _signupController.stream.listen(_onSignup);
  }

  void _onSignup(SignupInfo info) {
    if (info.password != info.passwordConf) {
      _errorController.add("Passwords do not match");
      return;
    }

    loginClient.signUp(info.username, info.password).then((_) {
      return loginClient.login(info.username, info.password);
    }).then((creds) {
      return credentialsKeeper.save(creds);
    }).then((_) {
      _userCreatedController.add(null);
    }).catchError((err) {
      _errorController.add(err.toString());
    });
  }

  void close() {
    _signupController.close();
    _errorController.close();
    _userCreatedController.close();
  }
}
