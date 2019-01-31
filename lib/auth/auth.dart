import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:race_place/auth/creds.dart';

final AuthClient loginClient = new AuthClient._private();

class AuthClient {
  AuthClient._private();

  Future<Creds> login(String username, String password) {
    return _post("https://skyfrog.auth0.com/oauth/token",
            _loginBody(username, password))
        .then((response) {
      return Creds.fromJson(response.body);
    });
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
  return jsonEncode(_toMap(username, password));
}

Map<String, dynamic> _toMap(String username, String password) =>
    <String, dynamic>{
      'username': username,
      'password': password,
      'client_id': 'Rl8sIgBzS5kLqGUYVHSuivXJdnqwGP2m',
      'grant_type': 'password',
      'scope': 'openid profile email address phone offline_access'
    };
