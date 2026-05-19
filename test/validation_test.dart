import 'package:test/test.dart';
import 'package:dartdbpract/dartdbpract.dart';

void main() {
  test('validateRequired returns error for empty string', () {
    expect(Validators.validateRequired('', 'Name'), isNotNull);
    expect(Validators.validateRequired('  ', 'Name'), isNotNull);
  });

  test('validateRequired returns null for valid string', () {
    expect(Validators.validateRequired('John', 'Name'), isNull);
  });

  test('validatePositiveNumber returns error for zero or negative', () {
    expect(Validators.validatePositiveNumber(0, 'Price'), isNotNull);
    expect(Validators.validatePositiveNumber(-5, 'Price'), isNotNull);
  });

  test('validatePositiveNumber returns null for positive number', () {
    expect(Validators.validatePositiveNumber(100, 'Price'), isNull);
  });
}