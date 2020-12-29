import 'package:flutter/material.dart';
import 'package:flutter_login/auth.dart';
import 'package:flutter_login/data/database_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> implements AuthStateListener {
  BuildContext _ctx;

  HomeScreenState() {
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My contacts"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              this.onLogout();
            },
          )
        ],
      ),
      body: new Center(
        child: new Text("Welcome home!"),
      ),
    );
  }

  @override
  onAuthStateChanged(AuthState state) {
    if (state == AuthState.LOGGED_OUT)
      Navigator.of(_ctx).pushReplacementNamed("/login");
  }

  void onLogout() async {
    var db = new DatabaseHelper();
    await db.deleteUsers();

    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_OUT);
  }

  @override
  void dispose() {
    var authStateProvider = new AuthStateProvider();
    authStateProvider.unsuscribe(this);
    super.dispose();
  }
}
