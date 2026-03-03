import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  Future<sql.Database> database() async {
    var databasePath = await sql.getDatabasesPath();
    String path = join(databasePath, 'notes.db');
    // bump version to 2 if upgrade logic is added below
    var database = await sql.openDatabase(path, version: 2, onCreate: (sql.Database db, version) async{
      await db.execute(
        'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, image TEXT)'
      );
    }, onUpgrade: (sql.Database db, int oldVersion, int newVersion) async {
      if (oldVersion < 2) {
        // add image column for existing databases
        await db.execute('ALTER TABLE notes ADD COLUMN image TEXT');
      }
    });
    return database;
  }

  Future<void> insertData(String title, String description, {String? imagePath}) async {
    var db = await database();
    var values = {
      'title': title,
      'description': description,
    };
    if (imagePath != null) values['image'] = imagePath;

    var check = await db.insert('notes', values);
    if (check > 0) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Success',
          message: 'Note added successfully',
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
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

  Future<int> updateData(int id, String title, String description, {String? imagePath}) async {
    var db = await database();
    var values = {
      'title': title,
      'description': description,
    };
    if (imagePath != null) values['image'] = imagePath;
    return await db.update('notes', values, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map>> getData() async {
    var db = await database();
    return await db.rawQuery('SELECT * FROM notes ORDER BY id ASC');
  }

  Future<void> deleteData(int id) async {
    var db = await database();
    await db.rawDelete('DELETE FROM notes where id = ?', [id]);
  }
}
