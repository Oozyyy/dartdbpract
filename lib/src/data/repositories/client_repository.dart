import 'package:dartdbpract/dartdbpract.dart';
import 'package:sqlite3/sqlite3.dart';

class ClientRepository {
  Database get db => DatabaseHelper.database;

  void insert(Client client) {
    db.execute('''
      INSERT INTO clients(id, full_name, phone, email, address)
      VALUES(?, ?, ?, ?, ?)
    ''', [client.id, client.fullName, client.phone, client.email, client.address]);
  }

  List<Client> getAll() {
    final result = db.select('SELECT id, full_name, phone, email, address FROM clients');
    return result.map((row) => Client.fromMap(row)).toList();
  }

  void update(Client client) {
    db.execute('''
      UPDATE clients 
      SET full_name = ?, phone = ?, email = ?, address = ?
      WHERE id = ?
    ''', [client.fullName, client.phone, client.email, client.address, client.id]);
  }

  void delete(String id) {
    db.execute('DELETE FROM clients WHERE id = ?', [id]);
  }

  Client? getById(String id) {
    final result = db.select('SELECT id, full_name, phone, email, address FROM clients WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    return Client.fromMap(result.first);
  }
}