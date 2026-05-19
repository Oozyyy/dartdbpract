import 'package:dartdbpract/dartdbpract.dart';
import 'package:sqlite3/sqlite3.dart';

class CategoryRepository {
  Database get db => DatabaseHelper.database;

  void insert(Category category) {
    db.execute('INSERT INTO categories(id, name) VALUES(?, ?)', [category.id, category.name]);
  }

  List<Category> getAll() {
    final result = db.select('SELECT id, name FROM categories');
    return result.map((row) => Category.fromMap(row)).toList();
  }

  void update(Category category) {
    db.execute('UPDATE categories SET name = ? WHERE id = ?', [category.name, category.id]);
  }

  void delete(String id) {
    db.execute('DELETE FROM categories WHERE id = ?', [id]);
  }

  Category? getById(String id) {
    final result = db.select('SELECT id, name FROM categories WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    return Category.fromMap(result.first);
  }
}