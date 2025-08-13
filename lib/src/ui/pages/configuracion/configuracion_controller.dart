import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/src/ui/pages/login/login_page.dart';

class ConfiguracionController extends GetxController {
  void cerrarSesion() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Get.off(() => LoginPage());
  }
}
