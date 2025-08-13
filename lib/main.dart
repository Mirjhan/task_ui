import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/src/app.dart';
import 'package:tasks/src/models/user_preferences.dart';
import 'package:tasks/src/ui/widget/loading_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().initPrefs();
  Get.put(LoadingService());
  runApp(const MyApp());
}
