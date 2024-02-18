import 'package:course_app/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.loading});

  final onPressed;
  final String title;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: kIsWeb ? 350 : double.infinity,
      height: MediaQuery.of(context).size.height * 0.07,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          backgroundColor: MaterialStatePropertyAll(primary_color),
          foregroundColor: MaterialStatePropertyAll(bg_color),
        ),
        onPressed: onPressed,
        child: loading
            ? const CircularProgressIndicator(
                color: bg_color,
              )
            : Text(
                title,
                style: textTheme.headlineSmall!.copyWith(color: bg_color),
              ),
      ),
    );
  }
}
