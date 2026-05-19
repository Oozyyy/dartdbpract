class Validators {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName не может быть пустым';
    }
    return null;
  }

  static String? validatePositiveNumber(dynamic value, String fieldName) {
    if (value == null) return '$fieldName обязательно';
    
    double number;
    if (value is String) {
      if (value.trim().isEmpty) return '$fieldName не может быть пустым';
      number = double.tryParse(value) ?? -1;
    } else if (value is int || value is double) {
      number = value.toDouble();
    } else {
      return '$fieldName должен быть числом';
    }
    
    if (number <= 0) {
      return '$fieldName должен быть больше 0';
    }
    return null;
  }

  static String? validateYear(int year) {
    if (year < 1900 || year > DateTime.now().year + 1) {
      return 'Год должен быть между 1900 и ${DateTime.now().year + 1}';
    }
    return null;
  }

  static String? validatePhone(String phone) {
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(phone.replaceAll(' ', ''))) {
      return 'Введите корректный номер телефона (10-15 цифр)';
    }
    return null;
  }

  static String? validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Введите корректный email';
    }
    return null;
  }

  static String? validateDate(String dateStr) {
    try {
      DateTime.parse(dateStr);
      return null;
    } catch (e) {
      return 'Введите корректную дату в формате ГГГГ-ММ-ДД';
    }
  }
}