import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbwordManager {
  Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "Words.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE word(id INTEGER PRIMARY KEY autoincrement, wname TEXT )",

        );
      } );
    }
  }

  Future<int> insertWord(Words word) async {
    await openDb();
    return await _database.insert('word', word.toMap());
  }

  Future<List<Words>> getWordlist() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('word');
    return List.generate(maps.length, (i) {
      return Words(
      wname: maps[i]['wname']);
    });
  }

  Future<void> deleteWord(String name) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('word', where: "wname = ?", whereArgs: [name]);
    for(var temp in maps) {
      await _database.delete(
          'word',
          where: "id = ?", whereArgs: [temp['id']]
      );
    }
  }

  Future<bool> checkword(String name) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('word', where: "wname = ?", whereArgs: [name]);
    if (maps.length!=0)
    {
      print(maps);
      return Future<bool>.value(true);
    }
    else{
      return Future<bool>.value(false);
    }
  }


}

class Words {
  int id;
  String wname;
  Words({@required this.wname, this.id});
  Map<String, dynamic> toMap() {
    return {'wname': wname};
  }
}