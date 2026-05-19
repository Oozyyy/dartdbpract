import 'dart:io';
import 'package:dartdbpract/dartdbpract.dart';

class InputHelper {
  static String generateId() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  static void pressEnterToContinue() {
    stdout.write('\nНажмите Enter для продолжения...');
    stdin.readLineSync();
  }

  static void printHeader(String title) {
    print('\n' + '=' * 60);
    print('  $title');
    print('=' * 60);
  }

  static void printSuccess(String message) {
    print('[SUCCESS] $message');
  }

  static void printError(String message) {
    print('[ERROR] $message');
  }

  static String askString(String prompt, String fieldName) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync();
      final error = Validators.validateRequired(input, fieldName);
      if (error == null && input != null) {
        return input.trim();
      }
      printError(error!);
    }
  }

  static String askPhone(String prompt) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync();
      if (input == null || input.trim().isEmpty) {
        printError('Телефон не может быть пустым');
        continue;
      }
      final error = Validators.validatePhone(input);
      if (error == null) {
        return input.trim();
      }
      printError(error);
    }
  }

  static String askEmail(String prompt) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync();
      if (input == null || input.trim().isEmpty) {
        printError('Email не может быть пустым');
        continue;
      }
      final error = Validators.validateEmail(input);
      if (error == null) {
        return input.trim();
      }
      printError(error);
    }
  }

  static String askDate(String prompt) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync();
      if (input == null || input.trim().isEmpty) {
        printError('Дата не может быть пустой');
        continue;
      }
      final error = Validators.validateDate(input);
      if (error == null) {
        return input.trim();
      }
      printError(error);
    }
  }

  static int askPositiveInt(String prompt, String fieldName) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync();
      if (input == null || input.trim().isEmpty) {
        printError('$fieldName не может быть пустым');
        continue;
      }
      final number = int.tryParse(input);
      if (number != null && number > 0) {
        return number;
      }
      printError('$fieldName должен быть положительным числом');
    }
  }

  static double askPositiveDouble(String prompt, String fieldName) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync();
      if (input == null || input.trim().isEmpty) {
        printError('$fieldName не может быть пустым');
        continue;
      }
      final number = double.tryParse(input);
      if (number != null && number > 0) {
        return number;
      }
      printError('$fieldName должен быть положительным числом');
    }
  }

  static String askStringOptional(String prompt, String defaultValue) {
    stdout.write('$prompt ($defaultValue): ');
    final input = stdin.readLineSync();
    if (input == null || input.trim().isEmpty) {
      return defaultValue;
    }
    return input.trim();
  }
}