import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:flutter_login/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var db = await openDatabase(path, version: 5, onCreate: _onCreate);

    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE User(token TEXT)");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int query = await dbClient.insert("User", user.toMap());

    return query;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    var query = await dbClient.delete("User");

    return query;
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var query = await dbClient.query("User");

    return query.length > 0 ? true : false;
  }

  Future<String> token() async {
    var dbClient = await db;
    var query = await dbClient.query("User");
    var user = User.fromJson(query[0]);

    return user.token;
  }
}
