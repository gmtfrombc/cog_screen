import 'package:cog_screen/models/survey_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SurveyProvider extends ChangeNotifier {
  final List<Question> _questions;
  final List<UserResponse> _userResponses = [];
  int _currentQuestionIndex = 0;
  String? _selectOption;
  int _totalScore = 0;

  bool _hasSeenInstructionForQuestion4 = false;
  bool _hasSeenInstructionForQuestion7 = false;
  bool _surveyEnded = false;
  bool _hasSeenFinishInstruction = false;

  List<Question> get questions => _questions;
  List<UserResponse> get userResponses => _userResponses;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  String? get selectedOption => _selectOption;
  bool get surveyEnded => _surveyEnded;
  int get totalScore => _totalScore;

  bool get shouldShowFinishInstruction {
    // Assuming this instruction should appear before question 4's instructions
    return _currentQuestionIndex == 3 &&
        !_hasSeenFinishInstruction &&
        !_hasSeenInstructionForQuestion4;
  }

  // Check whether to show instructions before question 4
  bool get shouldShowInstructionForQuestion4 {
    return _currentQuestionIndex == 3 &&
        !_hasSeenInstructionForQuestion4; // Index 3 is before question id='4'
  }

  // Check whether to show instructions before question 7
  bool get shouldShowInstructionForQuestion7 {
    return _currentQuestionIndex == 6 &&
        !_hasSeenInstructionForQuestion7; // Index 6 is before question id='7'
  }

  SurveyProvider({
    required questions,
  }) : _questions = questions;

  void selectOption(String option) {
    _selectOption = option;
    notifyListeners();
  }

  void seeFinishInstruction() {
    _hasSeenFinishInstruction = true;
    notifyListeners();
  }

  void seeInstructionForQuestion4() {
    _hasSeenInstructionForQuestion4 = true;
    notifyListeners();
  }

  void seeInstructionForQuestion7() {
    _hasSeenInstructionForQuestion7 = true;
    notifyListeners();
  }

  void addResponse(String userAnswer) {
    String currentQuestionId = _questions[_currentQuestionIndex].id;
    UserResponse response =
        UserResponse(userAnswer: userAnswer, questionId: currentQuestionId);
    _userResponses.add(response);

    // Update the score based on the current question and user's answer
    updateScore(currentQuestion, userAnswer);
    notifyListeners();
  }

  void updateScore(Question question, String userAnswer) {
    if (question.id == "1" &&
        question.correctAnswer ==
            DateFormat('MM/dd/yyyy').format(DateTime.now())) {
      _totalScore += 1;
    } else if (question.id == "7") {
      _totalScore += calculateScoreForQuestion7(userAnswer);
    } else if (question.validateAnswer(userAnswer)) {
      _totalScore += 1;
    }
    notifyListeners(); // Notify listeners about the change in total score
  }

  int calculateScoreForQuestion7(String userAnswer) {
    int numOfAnimals = int.tryParse(userAnswer) ?? 0;
    if (numOfAnimals == 0) {
      return 0;
    } else if (numOfAnimals >= 1 && numOfAnimals <= 5) {
      return 1;
    } else if (numOfAnimals >= 6 && numOfAnimals <= 12) {
      return 2;
    } else {
      return 3;
    }
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      // Check for specific question IDs before incrementing the index
      if (_questions[_currentQuestionIndex].id == '4') {
        _hasSeenInstructionForQuestion4 = false;
      }
      if (_questions[_currentQuestionIndex].id == '7') {
        _hasSeenInstructionForQuestion7 = false;
      }

      _currentQuestionIndex++;
      _selectOption = null;
    } else {
      endSurvey();
    }
    notifyListeners();
  }

  void endSurvey() {
    // Navigate to a new screen that shows the survey results
    _surveyEnded = true;
    notifyListeners();
  }

  // Method to reset the survey and start over
  void restartSurvey() {
    _currentQuestionIndex = 0;
    _userResponses.clear();
    _selectOption = null;
    _hasSeenInstructionForQuestion4 = false;
    _hasSeenInstructionForQuestion7 = false;
    _surveyEnded = false;
    _hasSeenFinishInstruction = false;
    _totalScore = 0; // Reset the score
    notifyListeners();
  }
}
