import 'dart:async';
import 'dart:convert';
import 'package:flutter_login/auth.dart';
import 'package:flutter_login/data/database_helper.dart';
import 'package:flutter_login/models/contact.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_login/models/user.dart';

class RestDatasource {
  static final BASE_URL = 'https://api.juanvargas.me/api';
  static final LOGIN_URL = BASE_URL + '/auth/login';
  static final CONTACTS_URL = BASE_URL + '/contacts';

  Future<User> login(String email, String password) async {
    final response = await http
        .post(LOGIN_URL, body: {"email": email, "password": password});

    return User.fromJson(json.decode(response.body));
  }

  Future<List<Contact>> contacts() async {
    var db = new DatabaseHelper();
    var token = await db.token();

    final response = await http
        .get(CONTACTS_URL, headers: {"Authorization": "Bearer ${token}"});

    var contactsResponse = json.decode(response.body)["contacts"] as List;

    var contacts = contactsResponse
        .map<Contact>((json) => Contact.fromJson(json))
        .toList();

    return contacts;
  }
}
