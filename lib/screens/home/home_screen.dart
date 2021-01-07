import 'package:flutter/material.dart';
import 'package:flutter_login/auth.dart';
import 'package:flutter_login/data/database_helper.dart';
import 'package:flutter_login/data/rest_datasource.dart';
import 'package:flutter_login/models/contact.dart';
import 'package:flutter_login/screens/detail/detail_screen.dart';
import 'package:flutter_login/screens/home/home_screen_presenter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>
    implements AuthStateListener, HomeScreenContract {
  BuildContext _ctx;
  List<Contact> entries = <Contact>[];
  AuthState authState;
  bool _isLoading = false;
  HomeScreenPresenter _presenter;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  HomeScreenState() {
    _presenter = new HomeScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  Future init() async {
    var isLoggedIn = await this._presenter.isLoggedIn();

    if (isLoggedIn) {
      setState(() => _isLoading = true);
      await this._presenter.getContacts();
    }
  }

  @override
  void initState() {
    super.initState();
    this.init();
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  void onGetContactsError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onGetContactsSuccess(List<Contact> contacts) {
    setState(() {
      entries = contacts;
      _isLoading = false;
    });
  }

  @override
  onAuthStateChanged(AuthState state) {
    if (state == AuthState.LOGGED_OUT)
      Navigator.of(_ctx).pushReplacementNamed("/login");
  }

  void onLogout() async {
    await this._presenter.deleteUser();
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_OUT);
  }

  @override
  void dispose() {
    var authStateProvider = new AuthStateProvider();
    authStateProvider.unsuscribe(this);
    super.dispose();
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
                    color: Colors.deepPurple[500]))),
        backgroundColor: Colors.white,
        // bottomOpacity: 0.0,
        // elevation: 0.0,
        toolbarHeight: 70,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.deepPurple[500],
            tooltip: 'Logout',
            onPressed: () {
              this.onLogout();
            },
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: _isLoading
            ? new CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.deepPurple[500]),
              )
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            _ctx,
                            MaterialPageRoute(
                                builder: (_ctx) =>
                                    DetailScreen(contact: entries[index])));
                      },
                      child: Dismissible(
                          key: UniqueKey(),
                          background: Container(),
                          secondaryBackground: Container(
                            // child: Center(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.white,
                            ),
                            // ),
                            color: Colors.red,
                          ),
                          onDismissed: (DismissDirection direction) async {
                            // TO-DO Remove contact from database
                            await this._presenter.getContacts();
                          },
                          child: Container(
                              height: 58,
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                entries[index].avatar),
                                            radius: 22,
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${entries[index].name}",
                                                style: new TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${entries[index].address}",
                                                style:
                                                    new TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                          child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 20,
                                                color: Colors.deepPurple[500],
                                              )))
                                    ],
                                  )
                                ],
                              ))));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: entries.length),
      ),
    );
  }
}
