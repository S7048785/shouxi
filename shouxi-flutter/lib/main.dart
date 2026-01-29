import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shouxi/pages/emergency/emergency_controller.dart';
import 'package:shouxi/pages/splash/splash_page.dart';
import 'package:shouxi/theme/theme.dart';
import 'package:shouxi/theme/theme_controller.dart';

void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    themeController.loadTheme(context);
    return GetMaterialApp(
      title: '守息',
      theme: MyTheme(Theme.of(context).textTheme).light(),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()]
    );
  }
}