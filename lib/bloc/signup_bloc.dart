import 'dart:async';

import 'package:race_place/auth/auth.dart';
import 'package:race_place/auth/credentials_keeper.dart';

class SignupInfo {
  String username;
  String password;
  String passwordConf;

  SignupInfo(this.username, this.password, this.passwordConf);
}

enum SignUpStatus { Pending, Success, Waiting }

class SignupBloc {
  StreamController<SignupInfo> _signupController;
  StreamController<String> _errorController;
  StreamController<SignUpStatus> _signupStatusController;

  Sink<SignupInfo> get signup => _signupController.sink;

  Stream<SignUpStatus> whenStatusChanged;
  Stream<String> get whenError => _errorController.stream;

  SignupBloc() {
    _signupController = StreamController();
    _signupStatusController = StreamController();
    _errorController = StreamController();
    whenStatusChanged = _signupStatusController.stream.asBroadcastStream();

    _signupController.stream.listen(_onSignup);
  }

  void _onSignup(SignupInfo info) {
    if (info.password != info.passwordConf) {
      _errorController.add("Passwords do not match");
      return;
    }

    _signupStatusController.add(SignUpStatus.Pending);
    loginClient.signUp(info.username, info.password).then((_) {
      return loginClient.login(info.username, info.password);
    }).then((creds) {
      return credentialsKeeper.save(creds);
    }).then((_) {
      _signupStatusController.add(SignUpStatus.Success);
    }).catchError((err) {
      _signupStatusController.add(SignUpStatus.Waiting);
      _errorController.add(err.toString());
    });
  }

  void close() {
    _signupController.close();
    _errorController.close();
    _signupStatusController.close();
  }
}
