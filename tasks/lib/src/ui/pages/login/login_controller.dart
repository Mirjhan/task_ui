import 'package:get/get.dart';
import 'package:tasks/src/ui/pages/sign_up/sign_up_page.dart';

class LoginController extends GetxController {
  void goToSignUp() {
    Get.to(() => SignUpPage());
  }
}
