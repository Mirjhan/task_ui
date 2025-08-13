import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/src/models/user_preferences.dart';
import 'package:tasks/src/ui/pages/dashboard/content_page.dart';
import 'package:tasks/src/ui/pages/login/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget getHome() {
    bool isLogging = UserPreferences().prefs?.getBool('estaLogeado') ?? false;

    if (isLogging) return ContentPage();
    return LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: getHome(),
    );
  }
}
