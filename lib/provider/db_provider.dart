import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qr_reader_flutter/models/scan_model.dart';
export 'package:qr_reader_flutter/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    // Path de donde almanacenaremos la DB
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    // print(path);
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(''' 
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }

  //? De aqui para abajo esta el CRUD de la DB

  // Create - Creacion del registro de la tabla Scans en formato RAW
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // Verificar la DB
    final db = await database;
    final resp = await db.rawInsert('''
      INSERT INTO Scans ( id, tipo, valor ) 
        VALUES( $id, '$tipo', '$valor' )
      )
    ''');
    return resp;
  }

  // Otra forma de creacion de registro mas simple
  // Create - Creacion del registro de la tabla Scans
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  // Obtener o Leer el registro por el ID
  // Read by id - Get Scan by ID
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  // Leer todos los registros de la tabla Scans
  // Get All Scan
  Future<List<ScanModel?>> getAllScan() async {
    final db = await database;
    final res = await db.query('Scans');
    List<ScanModel> list =
        res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];

    return list;
  }

  // Obtener todos los registros segun su tipo
  // Get Scan by Tipo
  Future<List<ScanModel?>> getsScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
        SELECT * FROM Scans WHERE tipo = '$tipo' 
        ''');
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  //? UPDATE
  // Actualizar Registros de la tabla Scans
  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  //? DELETE
  // Borrar un registro por ID de la tabla Scans
  Future<int> deleteScanByID(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // Borrar todos los registros de la tabla Scans
  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }
}
