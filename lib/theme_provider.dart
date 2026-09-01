import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends InheritedWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const ThemeProvider({
    super.key,
    required this.themeNotifier,
    required super.child,
  });

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final current = themeNotifier.value;
    ThemeMode newMode;
    if (current == ThemeMode.light) {
      newMode = ThemeMode.dark;
    } else if (current == ThemeMode.dark) {
      newMode = ThemeMode.system;
    } else {
      newMode = ThemeMode.light;
    }
    themeNotifier.value = newMode;
    await prefs.setString('themeMode', newMode.name);
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return themeNotifier != oldWidget.themeNotifier;
  }
}