import 'package:flutter/material.dart';
import 'package:race_place/bloc/signup_bloc.dart';
import 'package:race_place/page/home_page.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupState();
}

class _SignupState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  SignupBloc _signupBloc;

  @override
  void initState() {
    super.initState();
    _signupBloc = SignupBloc();
    _signupBloc.whenSuccess.listen((_) {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              maintainState: false,
              builder: (BuildContext buildContext) => HomePage()),
          (route) => false);
    });
  }

  void _signUp() {
    var username = _usernameController.text;
    var password = _passwordController.text;
    var passwordConf = _confirmPassController.text;
    _signupBloc.signup.add(SignupInfo(username, password, passwordConf));
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
              ));
        });
  }

  Widget _body(error) {
    var passwordFocusNode = new FocusNode();
    var confirmPassFocusNode = new FocusNode();

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(hintText: "Username"),
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(passwordFocusNode),
            ),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(hintText: "Password"),
              focusNode: passwordFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(confirmPassFocusNode),
            ),
            TextFormField(
              obscureText: true,
              controller: _confirmPassController,
              decoration: InputDecoration(hintText: "Confirm Password"),
              focusNode: confirmPassFocusNode,
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
