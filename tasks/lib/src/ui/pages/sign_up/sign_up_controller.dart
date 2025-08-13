import 'package:get/get.dart';
import 'package:tasks/src/ui/pages/login/login_page.dart';

class SignUpController extends GetxController {
  void goToSignIn() {
    Get.to(() => LoginPage());
  }
}
