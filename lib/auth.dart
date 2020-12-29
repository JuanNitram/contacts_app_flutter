import 'package:flutter_login/data/database_helper.dart';

enum AuthState { LOGGED_IN, LOGGED_OUT }

abstract class AuthStateListener {
  void onAuthStateChanged(AuthState state);
}

class AuthStateProvider {
  static final AuthStateProvider _instance = new AuthStateProvider.internal();

  List<AuthStateListener> _suscribers;

  factory AuthStateProvider() => _instance;

  AuthStateProvider.internal() {
    _suscribers = new List<AuthStateListener>();
    initState();
  }

  void initState() async {
    var db = new DatabaseHelper();
    var isLoggedIn = await db.isLoggedIn();
    if (isLoggedIn)
      notify(AuthState.LOGGED_IN);
    else
      notify(AuthState.LOGGED_OUT);
  }

  void subscribe(AuthStateListener listener) {
    _suscribers.add(listener);
  }

  void unsuscribe(AuthStateListener listener) {
    _suscribers.remove(listener);
  }

  void dispose(AuthStateListener listener) {
    for (var l in _suscribers) {
      if (l == listener) _suscribers.remove(l);
    }
  }

  void notify(AuthState state) {
    _suscribers.forEach((AuthStateListener s) {
      s.onAuthStateChanged(state);
    });
  }
}
