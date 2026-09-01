import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'router.dart';
import 'theme_provider.dart';

void main() async {
  usePathUrlStrategy();

  final prefs = await SharedPreferences.getInstance();
  final savedTheme = prefs.getString('themeMode') ?? 'system';
  final initialTheme = savedTheme == 'dark' ? ThemeMode.dark
      : savedTheme == 'light' ? ThemeMode.light
      : ThemeMode.system;

  final themeNotifier = ValueNotifier<ThemeMode>(initialTheme);
  runApp(CalcApp(themeNotifier: themeNotifier));
}

class CalcApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const CalcApp({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themeNotifier: themeNotifier,
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, themeMode, child) {
          return MaterialApp.router(
            title: 'Практическая работа 1',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // 🌸 Основной цвет – розовый
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 236, 67, 124),
                brightness: Brightness.light,
              ),
              useMaterial3: true,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.pink,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              brightness: Brightness.dark,
            ),
            themeMode: themeMode,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}