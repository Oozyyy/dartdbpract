import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

class DatabaseHelper {
  static Database? _database;
  static String get dbPath => p.join(Directory.current.path, "motorsalon.db");

  static Database get database {
    if (_database == null) {
      _database = sqlite3.open(dbPath);
      _createTables();
    }
    return _database!;
  }

  static void _createTables() {
    _database!.execute('''
      CREATE TABLE IF NOT EXISTS brands(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL UNIQUE
      )
    ''');

    _database!.execute('''
      CREATE TABLE IF NOT EXISTS categories(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL UNIQUE
      )
    ''');

    _database!.execute('''
      CREATE TABLE IF NOT EXISTS clients(
        id TEXT PRIMARY KEY,
        full_name TEXT NOT NULL,
        phone TEXT NOT NULL,
        email TEXT NOT NULL,
        address TEXT
      )
    ''');

    _database!.execute('''
      CREATE TABLE IF NOT EXISTS employees(
        id TEXT PRIMARY KEY,
        full_name TEXT NOT NULL,
        position TEXT NOT NULL,
        phone TEXT NOT NULL,
        salary REAL NOT NULL,
        hire_date TEXT NOT NULL
      )
    ''');

    _database!.execute('''
      CREATE TABLE IF NOT EXISTS motorcycles(
        id TEXT PRIMARY KEY,
        model TEXT NOT NULL,
        brand_id TEXT NOT NULL,
        category_id TEXT NOT NULL,
        year INTEGER NOT NULL,
        price REAL NOT NULL,
        engine_volume TEXT NOT NULL,
        is_available INTEGER DEFAULT 1,
        FOREIGN KEY(brand_id) REFERENCES brands(id) ON DELETE CASCADE,
        FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE CASCADE
      )
    ''');
  }

  static void close() {
    _database?.close();
    _database = null;
  }
}