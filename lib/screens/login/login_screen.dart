import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_login/auth.dart';
import 'package:flutter_login/data/database_helper.dart';
import 'package:flutter_login/models/user.dart';
import 'package:flutter_login/screens/login/login_screen_presenter.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>
    implements LoginScreenContract, AuthStateListener {
  BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password;
  String _username;

  LoginScreenPresenter _presenter;

  LoginScreenState() {
    _presenter = new LoginScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin(_username, _password);
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  onAuthStateChanged(AuthState state) {
    if (state == AuthState.LOGGED_IN)
      Navigator.of(_ctx).pushReplacementNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    var loginBtn = RaisedButton(
        onPressed: _submit,
        child: Text("SIGN IN", style: TextStyle(fontSize: 18)),
        color: Colors.deepPurple[500],
        textColor: Colors.white,
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ));

    var loginForm = Column(
      children: <Widget>[
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  initialValue: 'user@user.com',
                  onSaved: (val) => _username = val,
                  validator: (val) {
                    return val.length < 10
                        ? "Username must have atleast 10 chars"
                        : null;
                  },
                  decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide:
                              BorderSide(color: Colors.deepPurple[500])),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide:
                              BorderSide(color: Colors.deepPurple[500]))),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  initialValue: 'password',
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide:
                              BorderSide(color: Colors.deepPurple[500])),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide:
                              BorderSide(color: Colors.deepPurple[500]))),
                ),
              ),
              new Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(color: Colors.deepPurple[500]),
                  )),
            ],
          ),
        ),
        new Container(
          child: _isLoading
              ? new CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.deepPurple[500]),
                )
              : loginBtn,
          width: _isLoading ? null : 250.0,
          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );

    return new Scaffold(
        appBar: null,
        key: scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/1.png"))),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Text(
                "Hello,\nWelcome Back!",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.deepPurple[500],
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: new Center(
                child: new ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: new Container(
                      child: loginForm,
                      height: 300.0,
                      width: 350.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(User user) async {
    _showSnackBar(user.toString());
    setState(() => _isLoading = false);

    var db = new DatabaseHelper();
    await db.saveUser(user);

    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }

  @override
  void dispose() {
    var authStateProvider = new AuthStateProvider();
    authStateProvider.unsuscribe(this);
    super.dispose();
  }
}
