import 'package:cog_screen/models/health_element.dart';
import 'package:flutter/material.dart';
// Import your HealthElement, ContentItem, and

class HealthElementProvider with ChangeNotifier {
  List<HealthElement> _healthElements = [];
  HealthElement? _currentHealthElement;

  HealthElementProvider() {
    _initializeHealthElements();
  }

  List<HealthElement> get healthElements => _healthElements;
  HealthElement? get currentHealthElement => _currentHealthElement;

  void _initializeHealthElements() {
    _healthElements = elements;
    // Optionally, set the first element as the current element, or based on some logic
    if (_healthElements.isNotEmpty) {
      _currentHealthElement =
          _healthElements.firstWhere((element) => element.isActive);
    }
    notifyListeners();
  }

  void setCurrentHealthElement(HealthElement element) {
    _currentHealthElement = element;
    notifyListeners();
  }
}
