import 'package:flutter/material.dart';

class HomeScreenController extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  chngSelectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
}
