import 'package:dartdbpract/dartdbpract.dart';
import 'package:sqlite3/sqlite3.dart';

class BrandRepository {
  Database get db => DatabaseHelper.database;

  void insert(Brand brand) {
    db.execute('INSERT INTO brands(id, name) VALUES(?, ?)', [brand.id, brand.name]);
  }

  List<Brand> getAll() {
    final result = db.select('SELECT id, name FROM brands');
    return result.map((row) => Brand.fromMap(row)).toList();
  }

  void update(Brand brand) {
    db.execute('UPDATE brands SET name = ? WHERE id = ?', [brand.name, brand.id]);
  }

  void delete(String id) {
    db.execute('DELETE FROM brands WHERE id = ?', [id]);
  }

  Brand? getById(String id) {
    final result = db.select('SELECT id, name FROM brands WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    return Brand.fromMap(result.first);
  }
}