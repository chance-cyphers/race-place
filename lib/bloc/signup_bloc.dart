import 'dart:async';

import 'package:race_place/auth/auth.dart';
import 'package:race_place/bloc/login_bloc.dart';

class SignupBloc {
  StreamController<LoginInfo> _signupController;
  StreamController<String> _errorController;
  StreamController _userCreatedController;

  Sink<LoginInfo> get signup => _signupController.sink;

  Stream get whenSuccess => _userCreatedController.stream;
  Stream<String> get whenError => _errorController.stream;

  SignupBloc() {
    _signupController = StreamController();
    _userCreatedController = StreamController();
    _errorController = StreamController();

    _signupController.stream.listen(_onSignup);
  }

  void _onSignup(LoginInfo info) {
    loginClient.signUp(info.username, info.password).then((_) {
      _userCreatedController.add(null);
    }).catchError((err) {
      _errorController.add("whoops");
    });
  }

  void close() {
    _signupController.close();
    _errorController.close();
    _userCreatedController.close();
  }
}
