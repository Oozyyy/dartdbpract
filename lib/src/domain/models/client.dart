import 'identity.dart';

class Client implements Identity {
  @override
  final String id;
  final String fullName;
  final String phone;
  final String email;
  final String address;

  const Client({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.address,
  });

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'] as String,
      fullName: map['full_name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'ID: $id | $fullName | $phone | $email | $address';
  }
}