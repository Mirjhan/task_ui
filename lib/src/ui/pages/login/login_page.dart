import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/src/ui/core/colors.dart';
import 'package:tasks/src/ui/core/strings.dart';
import 'package:tasks/src/ui/pages/login/login_controller.dart';
import 'package:tasks/src/ui/widget/input_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return GetBuilder<LoginController>(
      init: controller,
      builder: (_) => Scaffold(
        body: Stack(
          children: [
            circle(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(height: 250),
                    titulo(),
                    InputWidget(
                      hintText: 'Correo',
                      prefixIconData: Icons.person,
                      onChanged: (p0) => controller.correo = p0,
                    ),
                    InputWidget(
                      hintText: 'Contraseña',
                      prefixIconData: Icons.lock_outline,
                      suffixIconData: Icons.visibility_outlined,
                      onChanged: (p0) => controller.contrasena = p0,
                    ),
                    checkBoxRemember(size),
                    SizedBox(height: 40),
                    botonSignIn(),
                    texto(),
                    texto2()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkBoxRemember(Size size) {
    return SizedBox(
      width: size.width,
      child: Row(
        children: [
          Expanded(
            child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              value: false,
              onChanged: (value) => {},
              title: Text(
                Strings.remember,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              activeColor: Colors.grey,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                Strings.forgot,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget titulo() {
    final TextStyle style = TextStyle(
      color: darkPrimaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 25,
    );
    final EdgeInsets padding = EdgeInsets.only(bottom: 20);

    return Container(
      alignment: Alignment.topCenter,
      padding: padding,
      child: Text(Strings.titleLogin, style: style),
    );
  }

  Widget circle() {
    return Positioned(
      top: -420,
      left: -120,
      right: -120,
      child: CircleAvatar(backgroundColor: darkPrimaryColor, radius: 300),
    );
  }

  Widget texto2() {
    final TextStyle style = TextStyle(
        color: darkPrimaryColor, fontWeight: FontWeight.w800, fontSize: 15);

    return GestureDetector(
      onTap: controller.goToSignUp,
      child: Text(Strings.goToRegister, style: style),
    );
  }

  Widget texto() {
    final TextStyle style = TextStyle(
        color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 15);

    return Text(Strings.withoutAccount, style: style);
  }

  Widget botonSignIn() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: GestureDetector(
        onTap: controller.enviar,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: darkPrimaryColor,
          ),
          child: Center(
            child: Text(
              'SIGN IN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
