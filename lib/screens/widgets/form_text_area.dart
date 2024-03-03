import 'package:flutter/material.dart';

class FormTextArea extends StatelessWidget {
  const FormTextArea({
    super.key,
    required this.title,
    required this.controller,
    required this.focus,
  });
  final String title;
  final TextEditingController controller;
  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        focusNode: focus,
        maxLines:
            6, // any number you need (It works as the rows for the textarea)
        keyboardType: TextInputType.multiline,
        // maxLines: null,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            label: Text(title)),
      ),
    );
  }
}
