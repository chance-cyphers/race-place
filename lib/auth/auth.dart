import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import 'package:race_place/auth/creds.dart';

final AuthClient loginClient = new AuthClient._private();

class AuthClient {
  AuthClient._private();

  Future<Creds> login(String username, String password) {
    return _post("https://skyfrog.auth0.com/oauth/token",
            _loginBody(username, password))
        .then((response) {
      if (response.statusCode != 200) {
        return Future.error(Error());
      }
      return Creds.fromJson(response.body);
    });
  }

  Future signUp(String username, String password) {
    return _post("https://skyfrog.auth0.com/dbconnections/signup",
            _signUpBody(username, password))
        .then((response) {
      if (response.statusCode != 200) {
        return Future.error(_parseErrorMsg(response));
      }
    });
  }

  String _parseErrorMsg(Response response) {
    var errorMsg1 = jsonDecode(response.body)['error'];
    var errorMsg2 = jsonDecode(response.body)['message'];
    var errorMsg3 = jsonDecode(response.body)['description'];

    return
      errorMsg1 != null ? errorMsg1 :
      errorMsg2 != null ? errorMsg2 :
      errorMsg3 != null ? errorMsg3 :
      "An error occurred";
  }

  Future<http.Response> _post(String url, String json) {
    return http.post(url,
        body: json,
        headers: {"Content-Type": "application/json"}).catchError((err) {
      print("ERRORZ: ${err.toString()}");
    });
  }
}

String _loginBody(String username, String password) {
  return jsonEncode(_loginMap(username, password));
}

String _signUpBody(String username, String password) {
  return jsonEncode(<String, dynamic>{
    'email': username,
    'password': password,
    'connection': 'Username-Password-Authentication'
  });
}

Map<String, dynamic> _loginMap(String username, String password) =>
    <String, dynamic>{
      'username': username,
      'password': password,
      'client_id': 'Rl8sIgBzS5kLqGUYVHSuivXJdnqwGP2m',
      'grant_type': 'password',
      'scope': 'openid profile email address phone offline_access'
    };
