import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/src/ui/pages/sign_up/sign_up_controller.dart';
import 'package:tasks/src/ui/widget/input_widget.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final SignUpController controller = SignUpController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      init: controller,
      builder: (controller) => Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            Positioned(
              top: -565,
              left: -120,
              right: -120,
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 57, 103, 215),
                radius: 400,
                child: Icon(
                  Icons.task_outlined,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Color.fromARGB(255, 57, 103, 215),
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    InputWidget(
                        hintText: 'Nombre', prefixIconData: Icons.person),
                    InputWidget(
                        hintText: 'Apellido', prefixIconData: Icons.person_2),
                    InputWidget(
                        hintText: 'Correo', prefixIconData: Icons.email),
                    InputWidget(
                        hintText: 'Contraseña',
                        prefixIconData: Icons.lock_outline,
                        suffixIconData: Icons.visibility_outlined),
                    InputWidget(
                        hintText: 'Repetir contraseña',
                        prefixIconData: Icons.lock_outline,
                        suffixIconData: Icons.visibility_outlined),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: false,
                      onChanged: (value) => {},
                      contentPadding: EdgeInsets.zero,
                      title: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'I agree to the ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                            text: 'Terms and Conditions.',
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 103, 215),
                              fontWeight: FontWeight.bold,
                            ))
                      ])),
                    ),
                    botonSignUp(),
                    texto(),
                    texto2()
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget texto2() {
    return Center(
      child: GestureDetector(
        onTap: controller.goToSignIn,
        child: Text(
          'Sign In from here',
          style: TextStyle(
            color: Color.fromARGB(255, 57, 103, 215),
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget texto() {
    return Center(
      child: Text(
        'Already have an account?',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget botonSignUp() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Color.fromARGB(255, 57, 103, 215),
        ),
        child: Center(
          child: Text(
            'SIGN UP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
