import 'dart:async';
import 'dart:convert';
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
}
