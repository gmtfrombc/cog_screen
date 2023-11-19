import 'package:flutter/material.dart';

class AppNavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void navigateTo(int index) {
    debugPrint('navigateTo called with index: $index');
    debugPrint('Current index before update: $_currentIndex');
    _currentIndex = index;
    notifyListeners();
    debugPrint('Current index set to $index and listeners notified');
  }
}
