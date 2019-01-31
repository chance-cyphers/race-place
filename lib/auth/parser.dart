import 'dart:convert';

String getName(String idToken) {
  var claims = _getClaims(idToken);
  return claims['name'];
}

Map<String, dynamic> _getClaims(String idToken) {
  var claimsSection = idToken.split(".")[1];
  var utfGarbage = base64.decode(claimsSection + "=");
  var json = utf8.decode(utfGarbage);
  return jsonDecode(json);
}