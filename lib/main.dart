import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:race_place/page/login_page.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Race Place',
      home: LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}
