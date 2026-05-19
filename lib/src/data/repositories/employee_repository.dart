import 'package:dartdbpract/dartdbpract.dart';
import 'package:sqlite3/sqlite3.dart';

class EmployeeRepository {
  Database get db => DatabaseHelper.database;

  void insert(Employee employee) {
    db.execute('''
      INSERT INTO employees(id, full_name, position, phone, salary, hire_date)
      VALUES(?, ?, ?, ?, ?, ?)
    ''', [
      employee.id,
      employee.fullName,
      employee.position,
      employee.phone,
      employee.salary,
      employee.hireDate.toIso8601String()
    ]);
  }

  List<Employee> getAll() {
    final result = db.select('SELECT id, full_name, position, phone, salary, hire_date FROM employees');
    return result.map((row) => Employee.fromMap(row)).toList();
  }

  void update(Employee employee) {
    db.execute('''
      UPDATE employees 
      SET full_name = ?, position = ?, phone = ?, salary = ?, hire_date = ?
      WHERE id = ?
    ''', [
      employee.fullName,
      employee.position,
      employee.phone,
      employee.salary,
      employee.hireDate.toIso8601String(),
      employee.id
    ]);
  }

  void delete(String id) {
    db.execute('DELETE FROM employees WHERE id = ?', [id]);
  }

  Employee? getById(String id) {
    final result = db.select('SELECT id, full_name, position, phone, salary, hire_date FROM employees WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    return Employee.fromMap(result.first);
  }
}