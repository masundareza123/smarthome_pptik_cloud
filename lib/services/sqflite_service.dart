import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:smarthome_cloud/models/device_data.dart';
class Db{
  //static final Db instance = Db._createObject();
  static Db _db;
  static Database _database;
  Db._createObject();

  factory Db() {
    if (_db == null) {
      _db = Db._createObject();
    }
    return _db;
  }

  Future<Database> get database async {
    if(_database != null)
      return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getExternalStorageDirectory();
    String path = join(directory.path, "devices.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int verion) async {
        await db.execute(
          "CREATE TABLE devices(guid TEXT PRIMARY KEY, mac TEXT, type TEXT, quantity TEXT, name TEXT, version TEXT, minor TEXT)"
        );
      }
    );
  }

  // addDevice(Device device) async {
  //   final db = await database;
  //   var raw = await db.insert(
  //       'devices',
  //       device.toMap(),
  //   );
  //   return raw;
  // }
  Future <void> addDevice (Device device) async {
    final Database db = await database;
    await db.insert(
        'devices',
        device.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Device>> getAllDevice() async {
    final db = await database;
    var response = await db.query('devices');
    List<Device> list = response.map((c) => Device.fromMap(c)).toList();
    print('$response');
    return list;
  }
}