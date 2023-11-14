import 'package:cog_screen/models/survey_model.dart';
import 'package:flutter/material.dart';

class SurveyProvider extends ChangeNotifier {
  final List<Question> _questions;
  final List<UserResponse> _userResponses = [];
  int _currentQuestionIndex = 0;
  String? _selectOption;

  List<Question> get questions => _questions;
  List<UserResponse> get userResponses => _userResponses;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  String? get selectedOption => _selectOption;

  SurveyProvider({
    required questions,
  }) : _questions = questions;

  void selectOption(String option) {
    _selectOption = option;
    notifyListeners();
  }

  void addResponse(String userAnswer) {
    String currentQuestionId = _questions[_currentQuestionIndex].id;
    _userResponses.add(
      UserResponse(userAnswer: userAnswer, questionId: currentQuestionId),
    );
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      endSurvey();
    }
    notifyListeners();
  }

  void endSurvey() {
    debugPrint('Survey has ended');
  }
}
