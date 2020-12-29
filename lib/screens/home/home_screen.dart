import 'package:flutter/material.dart';
import 'package:flutter_login/auth.dart';
import 'package:flutter_login/data/database_helper.dart';
import 'package:flutter_login/models/contact.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> implements AuthStateListener {
  BuildContext _ctx;

  List<Contact> entries = <Contact>[
    new Contact.fromJson({"name": "Laura", "address": "Mercedes 1540"}),
    new Contact.fromJson({"name": "Juan", "address": "Mercedes 1540"}),
    new Contact.fromJson({"name": "Lucas", "address": "Brasil 1635"}),
    new Contact.fromJson({"name": "Mario", "address": "Brasil 1635"}),
    new Contact.fromJson({"name": "Silvia", "address": "Brasil 1635"}),
    new Contact.fromJson({"name": "Laura", "address": "Mercedes 1540"}),
    new Contact.fromJson({"name": "Juan", "address": "Mercedes 1540"}),
    new Contact.fromJson({"name": "Lucas", "address": "Brasil 1635"}),
    new Contact.fromJson({"name": "Mario", "address": "Brasil 1635"}),
    new Contact.fromJson({"name": "Silvia", "address": "Brasil 1635"}),
  ];

  HomeScreenState() {
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Text("My contacts",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black))),
        backgroundColor: Colors.white,
        // bottomOpacity: 0.0,
        // elevation: 0.0,
        toolbarHeight: 70,
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
      body: Container(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 50,
                  color: null,
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.purple,
                                radius: 22,
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${entries[index].name}",
                                    style: new TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${entries[index].address}",
                                    style: new TextStyle(fontSize: 15),
                                  ),
                                ],
                              ))
                        ],
                      )
                    ],
                  ));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: entries.length),
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
