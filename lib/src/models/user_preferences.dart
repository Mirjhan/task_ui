import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = UserPreferences._internal();

  factory UserPreferences() => _instancia;

  UserPreferences._internal();

  SharedPreferences? prefs;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}
