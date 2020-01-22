import 'dart:io';
import 'package:flutter_sqlite_app/Model/UserDetails.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE UserDetails(empId TEXT PRIMARY KEY, firstname TEXT, emailId TEXT, designation TEXT)");
  }

  Future<int> saveUser(UserDetails user) async {
    var dbClient = await db;
    int res = await dbClient.insert("UserDetails", user.toMap());
    return res;
  }

  Future<List<UserDetails>> getDBUser() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM UserDetails');
    List<UserDetails> employees = new List();
    for (int i = 0; i < list.length; i++) {
      var user =
      new UserDetails(list[i]["empId"], list[i]["firstname"], list[i]["emailId"],list[i]["designation"]);
      employees.add(user);
    }
    print(employees.length);
    for (int i = 0; i < list.length; i++) {
      print(employees[i].empId + " | " +  employees[i].firstName + " | " + employees[i].emailId + " | " + employees[i].designation);
    }
    return employees;
  }


  Future<int> deleteUsers(UserDetails user) async {
    var dbClient = await db;

    int res =
    await dbClient.rawDelete('DELETE FROM UserDetails WHERE empId = ?', [user.empId]);
    return res;
  }

  Future<bool> update(UserDetails user) async {
    var dbClient = await db;
    int res =   await dbClient.update("UserDetails", user.toMap(),
        where: "empId = ?", whereArgs: <String>[user.empId]);
    return res > 0 ? true : false;
  }
}
