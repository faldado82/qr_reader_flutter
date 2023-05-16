import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuIndex = 0;

  int get selectedMenuIndex => _selectedMenuIndex;

  set selectedMenuIndex(int i) {
    _selectedMenuIndex = i;
    notifyListeners();
  }
}
