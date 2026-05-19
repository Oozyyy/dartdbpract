import 'identity.dart';

class Motorcycle implements Identity {
  @override
  final String id;
  final String model;
  final String brandId;
  final String categoryId;
  final int year;
  final double price;
  final String engineVolume;
  final int isAvailable;

  const Motorcycle({
    required this.id,
    required this.model,
    required this.brandId,
    required this.categoryId,
    required this.year,
    required this.price,
    required this.engineVolume,
    this.isAvailable = 1,
  });

  factory Motorcycle.fromMap(Map<String, dynamic> map) {
    return Motorcycle(
      id: map['id'] as String,
      model: map['model'] as String,
      brandId: map['brand_id'] as String,
      categoryId: map['category_id'] as String,
      year: map['year'] as int,
      price: map['price'] as double,
      engineVolume: map['engine_volume'] as String,
      isAvailable: map['is_available'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'model': model,
      'brand_id': brandId,
      'category_id': categoryId,
      'year': year,
      'price': price,
      'engine_volume': engineVolume,
      'is_available': isAvailable,
    };
  }

  @override
  String toString() {
    return 'ID: $id | $model | ${year}г | ${price}₽ | ${engineVolume}cc | ${isAvailable == 1 ? "В наличии" : "Нет в наличии"}';
  }
}