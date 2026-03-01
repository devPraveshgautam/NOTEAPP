import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  Future<sql.Database> database() async {
    var databasePath = await sql.getDatabasesPath();
    String path = join(databasePath, 'notes.db');
    var database = await sql.openDatabase(path, version: 1, onCreate: (sql.Database db, version) async{
      await db.execute(
        'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)'
      );
    });
        return database;

  }
  Future<void> insertData(String title, String description) async {
    var db = await database();
    var check = await db.insert('notes', {
      'title': title,
      'description': description,
    });
    if(check > 0) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Success',
          message: 'Note added successfully',
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: 'Failed to insert data',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  Future<List<Map>> getData() async{
    var db = await database();
    return await db.rawQuery('SELECT * FROM notes');
  }
}
