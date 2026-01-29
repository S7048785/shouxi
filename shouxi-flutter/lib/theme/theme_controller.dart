import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shouxi/theme/theme.dart';

class ThemeController extends GetxController {
  late ThemeData lightTheme; // 实例化一次
  late ThemeData darkTheme; // 实例化一次

  late final _theme = lightTheme.obs;

  ThemeData get theme => _theme.value;

  @override
  void onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    var isDark = prefs.getBool("isDarkMode");

    if (isDark == null) {
      setThemeMode(false);
      isDark = false;
    }
    _theme.value = isDark ? darkTheme : lightTheme;
  }

  void loadTheme(BuildContext context) {
    lightTheme = MyTheme(Theme.of(context).textTheme).light();
    darkTheme = MyTheme(Theme.of(context).textTheme).dark();
  }

  void toggleTheme() {
    final isLight = identical(_theme.value, lightTheme); // 引用比较更稳妥
    _theme.value = isLight ? darkTheme : lightTheme;
    setThemeMode(isLight);
  }

  Future<void> setThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  bool get isDark => identical(_theme.value, darkTheme);
}
