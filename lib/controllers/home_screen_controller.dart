import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  chngSelectedIndex(int value) {
    _selectedIndex(value);
    update();
  }
}
