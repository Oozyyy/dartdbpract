import 'identity.dart';

class Employee implements Identity {
  @override
  final String id;
  final String fullName;
  final String position;
  final String phone;
  final double salary;
  final DateTime hireDate;

  const Employee({
    required this.id,
    required this.fullName,
    required this.position,
    required this.phone,
    required this.salary,
    required this.hireDate,
  });

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as String,
      fullName: map['full_name'] as String,
      position: map['position'] as String,
      phone: map['phone'] as String,
      salary: map['salary'] as double,
      hireDate: DateTime.parse(map['hire_date'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'position': position,
      'phone': phone,
      'salary': salary,
      'hire_date': hireDate.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ID: $id | $fullName | $position | $phone | ${salary}₽ | ${hireDate.toLocal().toString().split(' ')[0]}';
  }
}