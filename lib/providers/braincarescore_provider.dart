import 'package:flutter/material.dart';

class BrainHealthProvider with ChangeNotifier {
  final Map<String, int> _userResponses = {};
  int _totalScore = 0;

  void setUserResponse(String category, int rank) {
    _userResponses[category] = rank;
    notifyListeners();
  }

  int getUserResponse(String category) {
    return _userResponses[category] ?? -1;
  }

  void incrementTotalScore(int rank) {
    _totalScore += rank;
    notifyListeners();
  }

  int getTotalScore() {
    return _totalScore;
  }

  void restartSurvey() {
    _userResponses.clear();
    _totalScore = 0;
    notifyListeners();
  }
}
