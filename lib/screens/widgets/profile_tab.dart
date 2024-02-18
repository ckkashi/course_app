import 'package:course_app/utils/colors.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  final title;
  final icon;
  final onTap;
  const ProfileTab(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primary_color,
      elevation: 0,
      child: ListTile(
        onTap: onTap,
        textColor: bg_color,
        iconColor: bg_color,
        title: Text(title),
        trailing: Icon(this.icon),
      ),
    );
  }
}
