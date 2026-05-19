import 'identity.dart';

class Category implements Identity {
  @override
  final String id;
  final String name;

  const Category({required this.id, required this.name});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  @override
  String toString() {
    return 'ID: $id | $name';
  }
}