import 'package:cog_screen/data/survey_repository.dart';
import 'package:cog_screen/models/survey_model.dart';
import 'package:flutter/material.dart';

class SurveyProvider with ChangeNotifier {
  final Map<String, int> _userResponses = {};
  int _totalScore = 0;
  int _currentCategoryIndex = 0;
  String? _surveyType;
  final List<QuestionResponse> _responseHistory = [];

  String? get surveyType => _surveyType;

  SurveyProvider();

  void setSurveyType(String type) {
    _surveyType = type;
    _userResponses.clear();
    _totalScore = 0;
    _currentCategoryIndex = 0;

    notifyListeners();
  }

  void pushResponse(int categoryIndex, int rank) {
    _responseHistory.add(QuestionResponse(categoryIndex, rank));
    _totalScore += rank;
    notifyListeners();
  }

  void popResponse() {
    if (_responseHistory.isNotEmpty) {
      var lastResponse = _responseHistory.removeLast();
      _totalScore -= lastResponse.rank;
      _currentCategoryIndex = lastResponse.categoryIndex;
    } else {
      _currentCategoryIndex = 0;
    }
    notifyListeners();
  }

  void setUserResponse(String category, int index, int rank) {
    String key = '$category-$index';
    _userResponses[key] = rank;

    notifyListeners();
  }

  int getUserResponse(String category, int index) {
    String key = '$category-$index';

    return _userResponses[key] ?? -1;
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
    _currentCategoryIndex = 0;
    notifyListeners();
  }

  SurveyCategory getCurrentCategory() {
    if (_surveyType == null) {
      throw StateError('Survey type not set');
    }
    var data = SurveyRepository.getSurveyData(_surveyType!);

    if (_currentCategoryIndex >= data.length) {
      throw RangeError(
          'Survey Provider: Current category index $_currentCategoryIndex is out of range for survey type $_surveyType');
    }
    return data[_currentCategoryIndex];
  }

  int get currentCategoryIndex => _currentCategoryIndex;

  void incrementCategoryIndex() {
    _currentCategoryIndex++;
    notifyListeners();
  }
}
