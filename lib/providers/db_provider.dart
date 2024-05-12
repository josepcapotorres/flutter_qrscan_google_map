import 'dart:io';

import 'package:flutter_qrscan/models/scan_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    return _database ?? await initDB();
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, "ScansDB.db");

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("""
      CREATE TABLE Scans(
        id INTEGER PRIMARY KEY,
        type TEXT,
        value TEXT
      )
      """);
      },
    );
  }

  Future<int> newScanRaw(ScanModel newScan) async {
    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;

    // Verify db
    final db = await database;
    final res = await db.rawInsert("""
    INSERT INTO Scans (id, type, value)
      VALUES ("$id", "$type", "$value")
    """);

    return res;
  }

  Future<int> newScan(ScanModel newScan) async {
    // Verify db
    final db = await database;
    final res = await db.insert("Scans", newScan.toJson());

    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    // Verify db
    final db = await database;
    final res = await db.query("Scans", where: "id = ?", whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScans() async {
    // Verify db
    final db = await database;
    final res = await db.query("Scans");

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    // Verify db
    final db = await database;
    final res = await db.query("Scans", where: "type = ?", whereArgs: [type]);

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int> updateScan(ScanModel scan) async {
    // Verify db
    final db = await database;
    final res = await db
        .update("Scans", scan.toJson(), where: "id = ?", whereArgs: [scan.id]);

    return res;
  }

  Future<int> deleteScan(int id) async {
    // Verify db
    final db = await database;
    final res = await db.delete("Scans", where: "id = ?", whereArgs: [id]);

    return res;
  }

  Future<int> deleteScans() async {
    // Verify db
    final db = await database;
    final res = await db.delete("Scans");

    return res;
  }
}
