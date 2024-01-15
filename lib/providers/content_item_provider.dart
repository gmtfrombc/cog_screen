import 'package:cog_screen/models/health_element.dart';
import 'package:flutter/material.dart';

class ContentItemProvider with ChangeNotifier {
  List<ContentItem> _assessments = [];
  List<ContentItem> _integrativeHealth = [];
  List<ContentItem> _learningCenter = [];
  ContentItem?
      _currentContentItem; // Adding a new field for the current content item

  List<ContentItem> get assessments => _assessments;
  List<ContentItem> get integrativeHealth => _integrativeHealth;
  List<ContentItem> get learningCenter => _learningCenter;
  ContentItem? get currentContentItem =>
      _currentContentItem; // Getter for the current content item

  void setAssessments(List<ContentItem> items) {
    _assessments = items;
      debugPrint(
        'Assessments set: ${_assessments.map((e) => e.title).join(', ')}');

    notifyListeners();
  }

  void setIntegrativeHealth(List<ContentItem> items) {
    _integrativeHealth = items;
    notifyListeners();
  }

  void setLearningCenter(List<ContentItem> items) {
    _learningCenter = items;
    notifyListeners();
  }

  // New method to set the current content item
  void setCurrentContentItem(ContentItem item) {
    _currentContentItem = item;
    notifyListeners();
  }
}
