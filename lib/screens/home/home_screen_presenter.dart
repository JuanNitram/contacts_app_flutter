import 'package:flutter_login/data/database_helper.dart';
import 'package:flutter_login/data/rest_datasource.dart';
import 'package:flutter_login/models/contact.dart';

abstract class HomeScreenContract {
  void onGetContactsSuccess(List<Contact> contacts);
  void onGetContactsError(String errorTxt);
}

class HomeScreenPresenter {
  HomeScreenContract _view;
  RestDatasource api = new RestDatasource();

  HomeScreenPresenter(this._view);

  Future<bool> isLoggedIn() async {
    var db = new DatabaseHelper();
    return await db.isLoggedIn();
  }

  deleteUser() async {
    var db = new DatabaseHelper();
    await db.deleteUsers();
  }

  getContacts() {
    api
        .contacts()
        .then(
            (List<Contact> contacts) => {_view.onGetContactsSuccess(contacts)})
        .catchError(
            (Object error) => {_view.onGetContactsError(error.toString())});
  }

  removeContact(String id) {
    // api.
  }
}
