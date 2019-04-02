import 'package:flutter/material.dart';
import 'package:race_place/bloc/signup_bloc.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupState();
}

class _SignupState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  SignupBloc _signupBloc;

  @override
  void initState() {
    super.initState();
    _signupBloc = SignupBloc();
    _signupBloc.whenSuccess.listen((_) {
      Navigator.of(context).pop();
    });
  }

  void _signUp() {
    var username = _usernameController.text;
    var password = _passwordController.text;
    _signupBloc.signup.add(SignupInfo(username, password, ""));
  }

  @override
  void dispose() {
    super.dispose();
    _signupBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _signupBloc.whenError,
      initialData: "",
      builder: (context, snap) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Signup"),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: _body(snap.data),
            )
        );
      }
    );
  }

  Widget _body(error) {
    var passwordFocusNode = new FocusNode();

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(hintText: "Username"),
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(passwordFocusNode),
            ),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(hintText: "Password"),
              focusNode: passwordFocusNode,
              onFieldSubmitted: (_) => _signUp(),
            ),
            Text(error),
            RaisedButton(
              child: Text("Sign Up"),
              onPressed: _signUp,
            )
          ]),
    );
  }

}