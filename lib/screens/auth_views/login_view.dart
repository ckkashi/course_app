import 'package:course_app/controllers/firebase_controller.dart';
import 'package:course_app/screens/auth_views/register_view.dart';
import 'package:course_app/screens/widgets/form_field.dart';
import 'package:course_app/screens/widgets/round_button.dart';
import 'package:course_app/utils/colors.dart';
import 'package:course_app/utils/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController(text: 'ckkashi007@gmail.com');
  final passwordController = TextEditingController(text: '42372Kash43');
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final firebaseController = Provider.of<FirebaseController>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<FirebaseController>(builder: (context, value, _) {
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
                  login_string,
                  style: textTheme.displaySmall!.copyWith(
                      color: primary_color, fontWeight: FontWeight.w600),
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
                RoundButton(
                    title: login_string,
                    loading: value.loginLoading,
                    onPressed: () {
                      value.loginAccount(emailController.text,
                          passwordController.text, context);
                    }),
                const SizedBox(
                  height: 10,
                ),
                // Spacer(),
                RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: textTheme.titleMedium,
                        children: [
                      TextSpan(
                          text: 'Register',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterView(),
                                  ));
                            })
                    ])),
              ],
            ),
          ),
        ),
      );
    });
  }
}
