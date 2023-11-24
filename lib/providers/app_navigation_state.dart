import 'package:flutter/material.dart';

class AppNavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void navigateToScreen(String route, BuildContext context) {
    // Logic to determine the index based on the route
    int newIndex;
    switch (route) {
      case '/':
        newIndex = 0;
        break;
      case '/results':
        newIndex = 1;
        break;
      case '/shoppingCart':
        newIndex = 2;
        break;
      // Add other cases for different routes...
      default:
        newIndex = _currentIndex; // Keep the current index for other routes
    }

    if (newIndex != _currentIndex) {
      _currentIndex = newIndex;
      notifyListeners();
    }

    Navigator.pushNamed(context, route);
  }
}

