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
    if(_db != null) {
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
    await db.execute("CREATE TABLE User(email TEXT, token TEXT)");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());

    return res;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    var res = await dbClient.delete("User");

    return res;
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query("User");
    
    return res.length > 0? true: false;
  }
}