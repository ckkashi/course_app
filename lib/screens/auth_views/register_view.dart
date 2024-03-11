import 'package:course_app/controllers/firebase_controller.dart';
import 'package:course_app/screens/auth_views/login_view.dart';
import 'package:course_app/screens/widgets/form_field.dart';
import 'package:course_app/screens/widgets/round_button.dart';
import 'package:course_app/utils/colors.dart';
import 'package:course_app/utils/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode usernameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  final firebase_controller = Get.find<FirebaseController>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              // const Spacer(),
              Text(
                register_string,
                style: textTheme.displaySmall!.copyWith(
                    color: primary_color, fontWeight: FontWeight.w600),
              ),
              FormTextField(
                emailController: usernameController,
                emailFocus: usernameFocus,
                name: 'Username',
                password: false,
              ),
              FormTextField(
                emailController: emailController,
                emailFocus: emailFocus,
                name: 'Email',
                password: false,
              ),
              FormTextField(
                emailController: passwordController,
                emailFocus: passFocus,
                name: 'Password',
                password: true,
              ),
              Obx(
                () => RoundButton(
                  onPressed: () {
                    firebase_controller.createAccount(usernameController.text,
                        emailController.text, passwordController.text, context);
                  },
                  title: register_string,
                  loading: firebase_controller.registerLoading,
                ),
              ),
              // Spacer(),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      text: 'Already have an account? ',
                      style: textTheme.titleMedium,
                      children: [
                    TextSpan(
                        text: 'Login',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ));
                          })
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
