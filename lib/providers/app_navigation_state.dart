import 'package:flutter/material.dart';

class AppNavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    debugPrint('Current index is: $index');
    _currentIndex = index;
    notifyListeners();
  }

  void navigateToScreen(String route, BuildContext context) {
    // Logic to determine the index based on the route
    int newIndex;
    switch (route) {
      case '/home':
        newIndex = 0;
        break;
      case '/allresults':
        newIndex = 1;
        break;
      case '/shoppingCart':
        newIndex = 2;
        break;
      // Add other cases for different routes...
      default:
        newIndex = _currentIndex;
// Keep the current index for other routes
    }

    if (newIndex != _currentIndex) {
      _currentIndex = newIndex;
      notifyListeners();
    }

    Navigator.pushNamed(context, route) // Navigate to the route
        .then((value) {}); // Reset the index when returning
  }
}
