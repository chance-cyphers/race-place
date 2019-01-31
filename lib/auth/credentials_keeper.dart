import 'package:race_place/auth/creds.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final CredentialsKeeper credentialsKeeper = CredentialsKeeper._private();

class CredentialsKeeper {

  CredentialsKeeper._private();
  final storage = new FlutterSecureStorage();

  Future<void> save(Creds creds) {
    print('2');
    return storage.write(key: "access_token", value: creds.accessToken)
    .catchError((err) {
      print('3: ' + err.toString());
    });
  } // when we login

  Future<void> clear() {
    return storage.deleteAll();
  } // when we logout

  bool hasValidCreds() => false; // so we know to refresh or what

  Future<String> getCredentials() async {
    return storage.read(key: "access_token");
  } // retrieve them if they're not expired. Or refresh

}
