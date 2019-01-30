
import 'dart:convert';

class Creds {
  String idToken;
  String accessToken;
  String refreshToken;

  Creds(this.accessToken, this.refreshToken, this.idToken);

  factory Creds.fromJson(String json) {
    var map = jsonDecode(json);
    return Creds(map['access_token'], map['refresh_token'], map['id_token']);
  }
}
