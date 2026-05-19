import 'dart:io';
import 'package:dartdbpract/dartdbpract.dart';

class Menu {
  final _clientRepo = ClientRepository();
  final _brandRepo = BrandRepository();
  final _categoryRepo = CategoryRepository();
  final _employeeRepo = EmployeeRepository();
  final _motorcycleRepo = MotorcycleRepository();

  void run() {
    while (true) {
      print('');
      print('МОТОСАЛОН');
      print('1. Управление клиентами');
      print('2. Управление марками');
      print('3. Управление категориями');
      print('4. Управление сотрудниками');
      print('5. Управление мотоциклами');
      print('6. ПОКАЗАТЬ ВСЕ ДАННЫЕ');
      print('0. Выход');
      print('');

      final choice = stdin.readLineSync();
      switch (choice) {
        case '1':
          _manageClients();
          break;
        case '2':
          _manageBrands();
          break;
        case '3':
          _manageCategories();
          break;
        case '4':
          _manageEmployees();
          break;
        case '5':
          _manageMotorcycles();
          break;
        case '6':
          _showAllData();
          break;
        case '0':
          DatabaseHelper.close();
          print('До свидания!');
          return;
        default:
          InputHelper.printError('Неверный выбор');
      }
    }
  }

  void _showAllData() {
    InputHelper.printHeader('ВСЕ ДАННЫЕ ИЗ БАЗЫ ДАННЫХ');

    print('\nМАРКИ:');
    final brands = _brandRepo.getAll();
    if (brands.isEmpty) {
      print('  (пусто)');
    } else {
      for (var b in brands) {
        print('  - $b');
      }
    }

    print('\nКАТЕГОРИИ:');
    final categories = _categoryRepo.getAll();
    if (categories.isEmpty) {
      print('  (пусто)');
    } else {
      for (var c in categories) {
        print('  - $c');
      }
    }

    print('\nКЛИЕНТЫ:');
    final clients = _clientRepo.getAll();
    if (clients.isEmpty) {
      print('  (пусто)');
    } else {
      for (var c in clients) {
        print('  - $c');
      }
    }

    print('\nСОТРУДНИКИ:');
    final employees = _employeeRepo.getAll();
    if (employees.isEmpty) {
      print('  (пусто)');
    } else {
      for (var e in employees) {
        print('  - $e');
      }
    }

    print('\nМОТОЦИКЛЫ:');
    final motorcycles = _motorcycleRepo.getAllWithDetails();
    if (motorcycles.isEmpty) {
      print('  (пусто)');
    } else {
      for (var m in motorcycles) {
        final status = m['is_available'] == 1 ? 'В наличии' : 'Нет в наличии';
        print('  - ${m['model']} | ${m['brand_name']} | ${m['category_name']} | ${m['year']}г | ${m['price']}₽ | ${m['engine_volume']}cc | $status');
      }
    }

    InputHelper.pressEnterToContinue();
  }

  void _manageClients() {
    while (true) {
      InputHelper.printHeader('УПРАВЛЕНИЕ КЛИЕНТАМИ');
      print('1. Добавить клиента');
      print('2. Просмотреть всех клиентов');
      print('3. Обновить клиента');
      print('4. Удалить клиента');
      print('0. Назад');
      print('');

      final choice = stdin.readLineSync();
      switch (choice) {
        case '1':
          _addClient();
          break;
        case '2':
          _listClients();
          break;
        case '3':
          _updateClient();
          break;
        case '4':
          _deleteClient();
          break;
        case '0':
          return;
        default:
          InputHelper.printError('Неверный выбор');
      }
    }
  }

  void _addClient() {
    InputHelper.printHeader('ДОБАВЛЕНИЕ КЛИЕНТА');
    
    final fullName = InputHelper.askString('ФИО: ', 'ФИО');
    final phone = InputHelper.askPhone('Телефон: ');
    final email = InputHelper.askEmail('Email: ');
    final address = InputHelper.askStringOptional('Адрес', '');
    
    final client = Client(
      id: InputHelper.generateId(),
      fullName: fullName,
      phone: phone,
      email: email,
      address: address,
    );
    
    _clientRepo.insert(client);
    InputHelper.printSuccess('Клиент добавлен. ID: ${client.id}');
    InputHelper.pressEnterToContinue();
  }

  void _listClients() {
    InputHelper.printHeader('СПИСОК КЛИЕНТОВ');
    final clients = _clientRepo.getAll();
    if (clients.isEmpty) {
      print('Клиентов нет');
    } else {
      for (var c in clients) {
        print('- $c');
      }
    }
    InputHelper.pressEnterToContinue();
  }

  void _updateClient() {
    InputHelper.printHeader('ОБНОВЛЕНИЕ КЛИЕНТА');
    final id = InputHelper.askString('ID клиента: ', 'ID');
    final client = _clientRepo.getById(id);
    if (client == null) {
      InputHelper.printError('Клиент не найден');
      InputHelper.pressEnterToContinue();
      return;
    }
    
    print('Текущие данные: $client');
    final fullName = InputHelper.askString('Новое ФИО (${client.fullName}): ', 'ФИО');
    final phone = InputHelper.askPhone('Новый телефон (${client.phone}): ');
    final email = InputHelper.askEmail('Новый email (${client.email}): ');
    final address = InputHelper.askStringOptional('Новый адрес', client.address);
    
    final updatedClient = Client(
      id: client.id,
      fullName: fullName,
      phone: phone,
      email: email,
      address: address,
    );
    
    _clientRepo.update(updatedClient);
    InputHelper.printSuccess('Клиент обновлён');
    InputHelper.pressEnterToContinue();
  }

  void _deleteClient() {
    InputHelper.printHeader('УДАЛЕНИЕ КЛИЕНТА');
    _listClients();
    final id = InputHelper.askString('ID клиента для удаления: ', 'ID');
    _clientRepo.delete(id);
    InputHelper.printSuccess('Клиент удалён');
    InputHelper.pressEnterToContinue();
  }

  void _manageBrands() {
    while (true) {
      InputHelper.printHeader('УПРАВЛЕНИЕ МАРКАМИ');
      print('1. Добавить марку');
      print('2. Просмотреть все марки');
      print('3. Обновить марку');
      print('4. Удалить марку');
      print('0. Назад');
      print('');

      final choice = stdin.readLineSync();
      switch (choice) {
        case '1':
          final name = InputHelper.askString('Название марки: ', 'Название');
          _brandRepo.insert(Brand(id: InputHelper.generateId(), name: name));
          InputHelper.printSuccess('Марка добавлена');
          break;
        case '2':
          InputHelper.printHeader('СПИСОК МАРОК');
          for (var b in _brandRepo.getAll()) {
            print('- $b');
          }
          break;
        case '3':
          final id = InputHelper.askString('ID марки: ', 'ID');
          final brand = _brandRepo.getById(id);
          if (brand == null) {
            InputHelper.printError('Марка не найдена');
          } else {
            final name = InputHelper.askString('Новое название (${brand.name}): ', 'Название');
            _brandRepo.update(Brand(id: brand.id, name: name));
            InputHelper.printSuccess('Марка обновлена');
          }
          break;
        case '4':
          final id = InputHelper.askString('ID марки для удаления: ', 'ID');
          _brandRepo.delete(id);
          InputHelper.printSuccess('Марка удалена');
          break;
        case '0':
          return;
      }
      InputHelper.pressEnterToContinue();
    }
  }

  void _manageCategories() {
    while (true) {
      InputHelper.printHeader('УПРАВЛЕНИЕ КАТЕГОРИЯМИ');
      print('1. Добавить категорию');
      print('2. Просмотреть все категории');
      print('3. Обновить категорию');
      print('4. Удалить категорию');
      print('0. Назад');
      print('');

      final choice = stdin.readLineSync();
      switch (choice) {
        case '1':
          final name = InputHelper.askString('Название категории: ', 'Название');
          _categoryRepo.insert(Category(id: InputHelper.generateId(), name: name));
          InputHelper.printSuccess('Категория добавлена');
          break;
        case '2':
          InputHelper.printHeader('СПИСОК КАТЕГОРИЙ');
          for (var c in _categoryRepo.getAll()) {
            print('- $c');
          }
          break;
        case '3':
          final id = InputHelper.askString('ID категории: ', 'ID');
          final category = _categoryRepo.getById(id);
          if (category == null) {
            InputHelper.printError('Категория не найдена');
          } else {
            final name = InputHelper.askString('Новое название (${category.name}): ', 'Название');
            _categoryRepo.update(Category(id: category.id, name: name));
            InputHelper.printSuccess('Категория обновлена');
          }
          break;
        case '4':
          final id = InputHelper.askString('ID категории для удаления: ', 'ID');
          _categoryRepo.delete(id);
          InputHelper.printSuccess('Категория удалена');
          break;
        case '0':
          return;
      }
      InputHelper.pressEnterToContinue();
    }
  }

  void _manageEmployees() {
    while (true) {
      InputHelper.printHeader('УПРАВЛЕНИЕ СОТРУДНИКАМИ');
      print('1. Добавить сотрудника');
      print('2. Просмотреть всех сотрудников');
      print('3. Обновить сотрудника');
      print('4. Удалить сотрудника');
      print('0. Назад');
      print('');

      final choice = stdin.readLineSync();
      switch (choice) {
        case '1':
          _addEmployee();
          break;
        case '2':
          _listEmployees();
          break;
        case '3':
          _updateEmployee();
          break;
        case '4':
          _deleteEmployee();
          break;
        case '0':
          return;
        default:
          InputHelper.printError('Неверный выбор');
      }
    }
  }

  void _addEmployee() {
    InputHelper.printHeader('ДОБАВЛЕНИЕ СОТРУДНИКА');
    
    final fullName = InputHelper.askString('ФИО: ', 'ФИО');
    final position = InputHelper.askString('Должность: ', 'Должность');
    final phone = InputHelper.askPhone('Телефон: ');
    final salary = InputHelper.askPositiveDouble('Зарплата: ', 'Зарплата');
    final hireDate = InputHelper.askDate('Дата найма (ГГГГ-ММ-ДД): ');
    
    final employee = Employee(
      id: InputHelper.generateId(),
      fullName: fullName,
      position: position,
      phone: phone,
      salary: salary,
      hireDate: DateTime.parse(hireDate),
    );
    
    _employeeRepo.insert(employee);
    InputHelper.printSuccess('Сотрудник добавлен. ID: ${employee.id}');
    InputHelper.pressEnterToContinue();
  }

  void _listEmployees() {
    InputHelper.printHeader('СПИСОК СОТРУДНИКОВ');
    final employees = _employeeRepo.getAll();
    if (employees.isEmpty) {
      print('Сотрудников нет');
    } else {
      for (var e in employees) {
        print('- $e');
      }
    }
    InputHelper.pressEnterToContinue();
  }

  void _updateEmployee() {
    InputHelper.printHeader('ОБНОВЛЕНИЕ СОТРУДНИКА');
    final id = InputHelper.askString('ID сотрудника: ', 'ID');
    final employee = _employeeRepo.getById(id);
    if (employee == null) {
      InputHelper.printError('Сотрудник не найден');
      InputHelper.pressEnterToContinue();
      return;
    }
    
    print('Текущие данные: $employee');
    final fullName = InputHelper.askString('Новое ФИО (${employee.fullName}): ', 'ФИО');
    final position = InputHelper.askString('Новая должность (${employee.position}): ', 'Должность');
    final phone = InputHelper.askPhone('Новый телефон (${employee.phone}): ');
    final salary = InputHelper.askPositiveDouble('Новая зарплата (${employee.salary}): ', 'Зарплата');
    
    final updatedEmployee = Employee(
      id: employee.id,
      fullName: fullName,
      position: position,
      phone: phone,
      salary: salary,
      hireDate: employee.hireDate,
    );
    
    _employeeRepo.update(updatedEmployee);
    InputHelper.printSuccess('Сотрудник обновлён');
    InputHelper.pressEnterToContinue();
  }

  void _deleteEmployee() {
    InputHelper.printHeader('УДАЛЕНИЕ СОТРУДНИКА');
    _listEmployees();
    final id = InputHelper.askString('ID сотрудника для удаления: ', 'ID');
    _employeeRepo.delete(id);
    InputHelper.printSuccess('Сотрудник удалён');
    InputHelper.pressEnterToContinue();
  }

  void _manageMotorcycles() {
    while (true) {
      InputHelper.printHeader('УПРАВЛЕНИЕ МОТОЦИКЛАМИ');
      print('1. Добавить мотоцикл');
      print('2. Просмотреть все мотоциклы');
      print('3. Обновить мотоцикл');
      print('4. Удалить мотоцикл');
      print('0. Назад');
      print('');

      final choice = stdin.readLineSync();
      switch (choice) {
        case '1':
          _addMotorcycle();
          break;
        case '2':
          _listMotorcycles();
          break;
        case '3':
          _updateMotorcycle();
          break;
        case '4':
          _deleteMotorcycle();
          break;
        case '0':
          return;
        default:
          InputHelper.printError('Неверный выбор');
      }
    }
  }

  void _addMotorcycle() {
    InputHelper.printHeader('ДОБАВЛЕНИЕ МОТОЦИКЛА');
    
    final model = InputHelper.askString('Модель: ', 'Модель');
    
    print('\nДоступные марки:');
    final brands = _brandRepo.getAll();
    if (brands.isEmpty) {
      InputHelper.printError('Сначала добавьте марку');
      InputHelper.pressEnterToContinue();
      return;
    }
    for (var b in brands) {
      print('  - ${b.id} | ${b.name}');
    }
    final brandId = InputHelper.askString('ID марки: ', 'ID марки');
    
    print('\nДоступные категории:');
    final categories = _categoryRepo.getAll();
    if (categories.isEmpty) {
      InputHelper.printError('Сначала добавьте категорию');
      InputHelper.pressEnterToContinue();
      return;
    }
    for (var c in categories) {
      print('  - ${c.id} | ${c.name}');
    }
    final categoryId = InputHelper.askString('ID категории: ', 'ID категории');
    
    final year = InputHelper.askPositiveInt('Год выпуска: ', 'Год');
    final price = InputHelper.askPositiveDouble('Цена: ', 'Цена');
    final engineVolume = InputHelper.askString('Объем двигателя (cc): ', 'Объем');
    
    final motorcycle = Motorcycle(
      id: InputHelper.generateId(),
      model: model,
      brandId: brandId,
      categoryId: categoryId,
      year: year,
      price: price,
      engineVolume: engineVolume,
    );
    
    _motorcycleRepo.insert(motorcycle);
    InputHelper.printSuccess('Мотоцикл добавлен. ID: ${motorcycle.id}');
    InputHelper.pressEnterToContinue();
  }

  void _listMotorcycles() {
    InputHelper.printHeader('СПИСОК МОТОЦИКЛОВ');
    final motorcycles = _motorcycleRepo.getAllWithDetails();
    if (motorcycles.isEmpty) {
      print('Мотоциклов нет');
    } else {
      for (var m in motorcycles) {
        final status = m['is_available'] == 1 ? 'В наличии' : 'Нет в наличии';
        print('- ${m['model']} | ${m['brand_name']} | ${m['category_name']} | ${m['year']}г | ${m['price']}₽ | ${m['engine_volume']}cc | $status');
      }
    }
    InputHelper.pressEnterToContinue();
  }

  void _updateMotorcycle() {
    InputHelper.printHeader('ОБНОВЛЕНИЕ МОТОЦИКЛА');
    final id = InputHelper.askString('ID мотоцикла: ', 'ID');
    final motorcycle = _motorcycleRepo.getById(id);
    if (motorcycle == null) {
      InputHelper.printError('Мотоцикл не найден');
      InputHelper.pressEnterToContinue();
      return;
    }
    
    print('Текущие данные: $motorcycle');
    
    final model = InputHelper.askString('Новая модель (${motorcycle.model}): ', 'Модель');
    
    print('\nДоступные марки:');
    for (var b in _brandRepo.getAll()) {
      print('  - ${b.id} | ${b.name}');
    }
    final brandId = InputHelper.askString('Новый ID марки (${motorcycle.brandId}): ', 'ID марки');
    
    print('\nДоступные категории:');
    for (var c in _categoryRepo.getAll()) {
      print('  - ${c.id} | ${c.name}');
    }
    final categoryId = InputHelper.askString('Новый ID категории (${motorcycle.categoryId}): ', 'ID категории');
    
    final year = InputHelper.askPositiveInt('Новый год (${motorcycle.year}): ', 'Год');
    final price = InputHelper.askPositiveDouble('Новая цена (${motorcycle.price}): ', 'Цена');
    final engineVolume = InputHelper.askString('Новый объем (${motorcycle.engineVolume}): ', 'Объем');
    
    final updatedMotorcycle = Motorcycle(
      id: motorcycle.id,
      model: model,
      brandId: brandId,
      categoryId: categoryId,
      year: year,
      price: price,
      engineVolume: engineVolume,
      isAvailable: motorcycle.isAvailable,
    );
    
    _motorcycleRepo.update(updatedMotorcycle);
    InputHelper.printSuccess('Мотоцикл обновлён');
    InputHelper.pressEnterToContinue();
  }

  void _deleteMotorcycle() {
    InputHelper.printHeader('УДАЛЕНИЕ МОТОЦИКЛА');
    _listMotorcycles();
    final id = InputHelper.askString('ID мотоцикла для удаления: ', 'ID');
    _motorcycleRepo.delete(id);
    InputHelper.printSuccess('Мотоцикл удалён');
    InputHelper.pressEnterToContinue();
  }
}