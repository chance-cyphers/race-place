import 'dart:async';

import 'package:race_place/auth/auth.dart';

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
    loginClient.signUp(info.username, info.password).then((_) {
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
