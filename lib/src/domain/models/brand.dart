import 'identity.dart';

class Brand implements Identity {
  @override
  final String id;
  final String name;

  const Brand({required this.id, required this.name});

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
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