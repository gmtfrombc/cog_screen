import 'package:cog_screen/data/survey_repository.dart';
import 'package:cog_screen/models/survey_model.dart';
import 'package:flutter/material.dart';

class SurveyProvider with ChangeNotifier {
  final Map<String, int> _userResponses = {};
  int _totalScore = 0;
  int _currentCategoryIndex = 0;
  final String _surveyType;

  SurveyProvider(this._surveyType);

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
    _currentCategoryIndex = 0; // Reset the index when restarting the survey
    notifyListeners();
  }

  SurveyCategory getCurrentCategory() {
    return SurveyRepository.getSurveyData(_surveyType)[_currentCategoryIndex];
  }

  int get currentCategoryIndex => _currentCategoryIndex;

  void incrementCategoryIndex() {
    _currentCategoryIndex++;
    notifyListeners();
  }
}
