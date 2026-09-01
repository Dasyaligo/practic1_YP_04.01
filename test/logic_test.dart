import 'package:flutter_test/flutter_test.dart';
import 'package:onlyphones/logic/calculator.dart';   // заменили на package:
import 'package:onlyphones/logic/currency.dart';    // заменили на package:

void main() {
  group('Тесты калькулятора', () {
    test('Сложение 2 + 3 = 5', () {
      final result = calculate('2', '+', '3');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 5.0);
    });

    test('Вычитание 10 - 4 = 6', () {
      final result = calculate('10', '-', '4');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 6.0);
    });

    test('Умножение 3 * 7 = 21', () {
      final result = calculate('3', '*', '7');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 21.0);
    });

    test('Деление 15 / 3 = 5', () {
      final result = calculate('15', '/', '3');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 5.0);
    });

    test('Деление на ноль → ошибка', () {
      final result = calculate('5', '/', '0');
      expect(result, isA<CalcFailure>());
      expect((result as CalcFailure).message, 'Деление на ноль невозможно');
    });

    test('Нечисловой ввод → ошибка', () {
      final result = calculate('abc', '+', '3');
      expect(result, isA<CalcFailure>());
      expect((result as CalcFailure).message, 'В адресе переданы не числа');
    });

    test('Неизвестная операция → ошибка', () {
      final result = calculate('5', '%', '3');
      expect(result, isA<CalcFailure>());
      expect((result as CalcFailure).message, 'Неизвестная операция');
    });
  });

  group('Тесты конвертера', () {
    test('USD → EUR: 100 USD = 85 EUR', () {
      final result = convert('100', 'USD', 'EUR');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 85.0);
    });

    test('EUR → USD: 100 EUR ≈ 117.65 USD', () {
      final result = convert('100', 'EUR', 'USD');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, closeTo(117.647, 0.001));
    });

    test('Неизвестная валюта → ошибка', () {
      final result = convert('100', 'XYZ', 'USD');
      expect(result, isA<CalcFailure>());
      expect((result as CalcFailure).message, 'Неизвестная валюта');
    });

    test('Отсутствие суммы → ошибка', () {
      final result = convert(null, 'USD', 'EUR');
      expect(result, isA<CalcFailure>());
      expect((result as CalcFailure).message, 'Сумма не указана или не число');
    });
  });
}