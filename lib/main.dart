import 'package:flutter/material.dart';
import 'package:flutter_login/screens/home/home_screen.dart';
import 'package:flutter_login/screens/login/login_screen.dart';

final routes = {
  // '/login': (BuildContext context) => new LoginScreen(),
  '/': (context) => HomeScreen(),
  '/login': (context) => LoginScreen(),
};

void main() => runApp(new FlutterLogin());

class FlutterLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Login',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
    );
  }
}
