import 'package:test/test.dart';
import 'package:dartdbpract/dartdbpract.dart';

void main() {
  group('Тесты моделей (сущностей)', () {
    
    group('Client', () {
      test('toMap должен правильно преобразовывать объект в Map', () {
        final client = Client(
          id: '123',
          fullName: 'Стас Бурденков',
          phone: '+79123456789',
          email: 'stas@mail.ru',
          address: 'Москва, ул. Ленина 10',
        );
        
        final map = client.toMap();
        
        expect(map['id'], equals('123'));
        expect(map['full_name'], equals('Стас Бурденков'));
        expect(map['phone'], equals('+79123456789'));
        expect(map['email'], equals('stas@mail.ru'));
        expect(map['address'], equals('Москва, ул. Ленина 10'));
      });
      
      test('fromMap должен правильно создавать объект из Map', () {
        final map = {
          'id': '123',
          'full_name': 'Стас Бурденков',
          'phone': '+79123456789',
          'email': 'stas@mail.ru',
          'address': 'Москва, ул. Ленина 10',
        };
        
        final client = Client.fromMap(map);
        
        expect(client.id, equals('123'));
        expect(client.fullName, equals('Стас Бурденков'));
        expect(client.phone, equals('+79123456789'));
        expect(client.email, equals('stas@mail.ru'));
        expect(client.address, equals('Москва, ул. Ленина 10'));
      });
    });
    
    group('Brand', () {
      test('toMap должен правильно преобразовывать объект в Map', () {
        final brand = Brand(id: '1', name: 'Harley-Davidson');
        final map = brand.toMap();
        
        expect(map['id'], equals('1'));
        expect(map['name'], equals('Harley-Davidson'));
      });
      
      test('fromMap должен правильно создавать объект из Map', () {
        final map = {'id': '1', 'name': 'Harley-Davidson'};
        final brand = Brand.fromMap(map);
        
        expect(brand.id, equals('1'));
        expect(brand.name, equals('Harley-Davidson'));
      });
    });
    
    group('Category', () {
      test('toMap должен правильно преобразовывать объект в Map', () {
        final category = Category(id: '1', name: 'Спорт');
        final map = category.toMap();
        
        expect(map['id'], equals('1'));
        expect(map['name'], equals('Спорт'));
      });
      
      test('fromMap должен правильно создавать объект из Map', () {
        final map = {'id': '1', 'name': 'Спорт'};
        final category = Category.fromMap(map);
        
        expect(category.id, equals('1'));
        expect(category.name, equals('Спорт'));
      });
    });
    
    group('Employee', () {
      test('toMap должен правильно преобразовывать объект в Map', () {
        final employee = Employee(
          id: '1',
          fullName: 'Сергей Иванов',
          position: 'Менеджер',
          phone: '+79123456789',
          salary: 50000.0,  
          hireDate: DateTime(2024, 1, 15),
        );
        
        final map = employee.toMap();
        
        expect(map['id'], equals('1'));
        expect(map['full_name'], equals('Сергей Иванов'));
        expect(map['position'], equals('Менеджер'));
        expect(map['phone'], equals('+79123456789'));
        expect(map['salary'], equals(50000.0));
        expect(map['hire_date'], equals('2024-01-15T00:00:00.000'));
      });
      
      test('fromMap должен правильно создавать объект из Map', () {
        final map = {
          'id': '1',
          'full_name': 'Сергей Иванов',
          'position': 'Менеджер',
          'phone': '+79123456789',
          'salary': 50000.0, 
          'hire_date': '2024-01-15T00:00:00.000',
        };
        
        final employee = Employee.fromMap(map);
        
        expect(employee.id, equals('1'));
        expect(employee.fullName, equals('Сергей Иванов'));
        expect(employee.position, equals('Менеджер'));
        expect(employee.phone, equals('+79123456789'));
        expect(employee.salary, equals(50000.0));
        expect(employee.hireDate, equals(DateTime(2024, 1, 15)));
      });
    });
    
    group('Motorcycle', () {
      test('toMap должен правильно преобразовывать объект в Map', () {
        final motorcycle = Motorcycle(
          id: '1',
          model: 'Sportster',
          brandId: '1',
          categoryId: '1',
          year: 2024,
          price: 1500000.0,  
          engineVolume: '1200',
          isAvailable: 1,
        );
        
        final map = motorcycle.toMap();
        
        expect(map['id'], equals('1'));
        expect(map['model'], equals('Sportster'));
        expect(map['brand_id'], equals('1'));
        expect(map['category_id'], equals('1'));
        expect(map['year'], equals(2024));
        expect(map['price'], equals(1500000.0));
        expect(map['engine_volume'], equals('1200'));
        expect(map['is_available'], equals(1));
      });
      
      test('fromMap должен правильно создавать объект из Map', () {
        final map = {
          'id': '1',
          'model': 'Sportster',
          'brand_id': '1',
          'category_id': '1',
          'year': 2024,
          'price': 1500000.0,  
          'engine_volume': '1200',
          'is_available': 1,
        };
        
        final motorcycle = Motorcycle.fromMap(map);
        
        expect(motorcycle.id, equals('1'));
        expect(motorcycle.model, equals('Sportster'));
        expect(motorcycle.brandId, equals('1'));
        expect(motorcycle.categoryId, equals('1'));
        expect(motorcycle.year, equals(2024));
        expect(motorcycle.price, equals(1500000.0));
        expect(motorcycle.engineVolume, equals('1200'));
        expect(motorcycle.isAvailable, equals(1));
      });
    });
  });
}