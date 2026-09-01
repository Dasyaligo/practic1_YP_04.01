import 'calculator.dart';

const currencies = ['USD', 'EUR', 'RUB', 'GBP', 'JPY'];
const rates = {
  'USD': 1.0,
  'EUR': 0.85,
  'RUB': 75.0,
  'GBP': 0.75,
  'JPY': 110.0,
};

CalcResult convert(String? rawAmount, String? from, String? to) {
  final amount = double.tryParse(rawAmount?.replaceAll(',', '.') ?? '');
  if (amount == null) {
    return const CalcFailure('Сумма не указана или не число');
  }
  if (from == null || to == null) {
    return const CalcFailure('Не указана валюта');
  }
  final fromRate = rates[from];
  final toRate = rates[to];
  if (fromRate == null || toRate == null) {
    return const CalcFailure('Неизвестная валюта');
  }
  final result = amount * (toRate / fromRate);
  return CalcSuccess(result);
}