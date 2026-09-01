import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../logic/calculator.dart';
import '../logic/currency.dart';

class ResultScreen extends StatelessWidget {
  final String title;
  final String expression;
  final Map<String, String> rawQuery;
  final String backPath;

  const ResultScreen({
    super.key,
    required this.title,
    required this.expression,
    required this.rawQuery,
    required this.backPath,
  });

  @override
  Widget build(BuildContext context) {
    CalcResult result;
    if (rawQuery.containsKey('a') &&
        rawQuery.containsKey('b') &&
        rawQuery.containsKey('op')) {
      result = calculate(rawQuery['a'], rawQuery['op'], rawQuery['b']);
    } else if (rawQuery.containsKey('amount') &&
        rawQuery.containsKey('from') &&
        rawQuery.containsKey('to')) {
      result = convert(rawQuery['amount'], rawQuery['from'], rawQuery['to']);
    } else {
      result = const CalcFailure('Неизвестный тип расчёта');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
          tooltip: 'На главную',
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  expression,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                if (result is CalcSuccess)
                  Text(
                    '= ${_formatResult(result.value)}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                else if (result is CalcFailure)
                  Text(
                    'Ошибка: ${result.message}',
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => context.go(backPath),
                  child: const Text('Вернуться назад'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatResult(double value) {
    String str = value.toString();
    if (str.contains('.')) {
      final parts = str.split('.');
      if (parts[1].length > 10) {
        return value.toStringAsFixed(10);
      }
    }
    return str;
  }
}