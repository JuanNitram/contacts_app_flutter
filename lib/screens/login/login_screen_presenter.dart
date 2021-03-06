import 'package:flutter_login/data/rest_datasource.dart';
import 'package:flutter_login/models/user.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(User user);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  RestDatasource api = new RestDatasource();
  LoginScreenPresenter(this._view);

  doLogin(String email, String password) {
    api.login(email, password).then((User user) {
      _view.onLoginSuccess(user);
    }).catchError((Exception error) => {_view.onLoginError(error.toString())});
  }
}
