import 'dart:async';
import 'dart:convert';
import 'package:flutter_login/models/contact.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_login/models/user.dart';

class RestDatasource {
  static final BASE_URL = 'https://sermonly2.rowandtable.com/api';
  static final LOGIN_URL = BASE_URL + '/login';

  Future<User> login(String email, String password) async {
    final response = await http
        .post(LOGIN_URL, body: {"email": email, "password": password});

    return User.fromJson(json.decode(response.body));
  }

  Future<List<Contact>> contacts() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/users");

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

    return entries;
  }
}
