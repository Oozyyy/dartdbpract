import 'package:dartdbpract/dartdbpract.dart';
import 'package:sqlite3/sqlite3.dart';

class MotorcycleRepository {
  Database get db => DatabaseHelper.database;

  void insert(Motorcycle motorcycle) {
    db.execute('''
      INSERT INTO motorcycles(id, model, brand_id, category_id, year, price, engine_volume, is_available)
      VALUES(?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      motorcycle.id,
      motorcycle.model,
      motorcycle.brandId,
      motorcycle.categoryId,
      motorcycle.year,
      motorcycle.price,
      motorcycle.engineVolume,
      motorcycle.isAvailable
    ]);
  }

  List<Motorcycle> getAll() {
    final result = db.select('SELECT id, model, brand_id, category_id, year, price, engine_volume, is_available FROM motorcycles');
    return result.map((row) => Motorcycle.fromMap(row)).toList();
  }

  void update(Motorcycle motorcycle) {
    db.execute('''
      UPDATE motorcycles 
      SET model = ?, brand_id = ?, category_id = ?, year = ?, price = ?, engine_volume = ?, is_available = ?
      WHERE id = ?
    ''', [
      motorcycle.model,
      motorcycle.brandId,
      motorcycle.categoryId,
      motorcycle.year,
      motorcycle.price,
      motorcycle.engineVolume,
      motorcycle.isAvailable,
      motorcycle.id
    ]);
  }

  void delete(String id) {
    db.execute('DELETE FROM motorcycles WHERE id = ?', [id]);
  }

  Motorcycle? getById(String id) {
    final result = db.select('SELECT id, model, brand_id, category_id, year, price, engine_volume, is_available FROM motorcycles WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    return Motorcycle.fromMap(result.first);
  }

  List<Map<String, dynamic>> getAllWithDetails() {
    final result = db.select('''
      SELECT 
        m.id, m.model, m.year, m.price, m.engine_volume, m.is_available,
        b.name as brand_name,
        c.name as category_name
      FROM motorcycles m
      JOIN brands b ON m.brand_id = b.id
      JOIN categories c ON m.category_id = c.id
    ''');
    return result;
  }
}