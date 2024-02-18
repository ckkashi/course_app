import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField(
      {super.key,
      required this.emailController,
      required this.emailFocus,
      required this.name,
      required this.password});

  final TextEditingController emailController;
  final FocusNode emailFocus;
  final String name;
  final bool password;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kIsWeb ? 350 : double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          obscureText: password,
          controller: emailController,
          focusNode: emailFocus,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              label: Text(name)),
        ),
      ),
    );
  }
}
