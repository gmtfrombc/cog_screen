// import 'package:cog_screen/models/cog_model.dart';
// import 'package:cog_screen/models/health_element.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CogProvider extends ChangeNotifier {
//   final List<Question> _questions;
//   final List<UserResponse> _userResponses = [];
//   int _currentQuestionIndex = 0;
//   String? _selectOption;
//   int _totalScore = 0;
//   bool _isTimerButtonEnabled = true; // New property
//   HealthElement? _currentHealthElement;
//   bool _hasSeenInstructionForQuestion4 = false;
//   bool _hasSeenInstructionForQuestion7 = false;
//   bool _surveyEnded = false;
//   bool _hasSeenFinishInstruction = false;
//   bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;
//   bool get isTimerButtonEnabled => _isTimerButtonEnabled;

//   List<Question> get questions => _questions;
//   List<UserResponse> get userResponses => _userResponses;
//   Question get currentQuestion => _questions[_currentQuestionIndex];
//   String? get selectedOption => _selectOption;
//   bool get surveyEnded => _surveyEnded;
//   int get totalScore => _totalScore;

//   HealthElement? get currentHealthElement => _currentHealthElement;

//   bool get shouldShowFinishInstruction {
//     // Assuming this instruction should appear before question 4's instructions
//     return _currentQuestionIndex == 3 &&
//         !_hasSeenFinishInstruction &&
//         !_hasSeenInstructionForQuestion4;
//   }

//   // Check whether to show instructions before question 4
//   bool get shouldShowInstructionForQuestion4 {
//     return _currentQuestionIndex == 3 &&
//         !_hasSeenInstructionForQuestion4; // Index 3 is before question id='4'
//   }

//   // Check whether to show instructions before question 7
//   bool get shouldShowInstructionForQuestion7 {
//     return _currentQuestionIndex == 6 &&
//         !_hasSeenInstructionForQuestion7; // Index 6 is before question id='7'
//   }

//   CogProvider({
//     required questions,
//   }) : _questions = questions;

//   void setCurrentHealthElement(HealthElement element) {
//     _currentHealthElement = element;
//     notifyListeners();
//   }

//   void selectOption(String option) {
//     _selectOption = option;
//     notifyListeners();
//   }

//   void seeFinishInstruction() {
//     _hasSeenFinishInstruction = true;
//     notifyListeners();
//   }

//   void seeInstructionForQuestion4() {
//     _hasSeenInstructionForQuestion4 = true;
//     notifyListeners();
//   }

//   void seeInstructionForQuestion7() {
//     _hasSeenInstructionForQuestion7 = true;
//     notifyListeners();
//   }

//   void addResponse(String userAnswer) {
//     String currentQuestionId = _questions[_currentQuestionIndex].id;
//     UserResponse response =
//         UserResponse(userAnswer: userAnswer, questionId: currentQuestionId);
//     _userResponses.add(response);

//     // Update the score based on the current question and user's answer
//     updateScore(currentQuestion, userAnswer);
//     notifyListeners();
//   }

//   void updateScore(Question question, String userAnswer) {
//     // Handling the date question
//     if (question.id == "1") {
//       try {
//         DateTime userDate = DateFormat('MM/dd/yyyy').parse(userAnswer.trim());
//         DateTime currentDate = DateTime.now();
//         if (userDate.year == currentDate.year &&
//             userDate.month == currentDate.month &&
//             userDate.day == currentDate.day) {
//           _totalScore += 1;
//         }
//       } catch (e) {
//         // Handle parse error if the user input is not a valid date
//         debugPrint("Error parsing date: $e");
//       }
//     }
//     // Handling Question 7 with custom scoring logic
//     else if (question.id == "7") {
//       _totalScore += calculateScoreForQuestion7(userAnswer);
//     }
//     // Handling other questions
//     else if (question.validateAnswer(userAnswer)) {
//       _totalScore += 1;
//     }

//     notifyListeners(); // Notify listeners of the score update
//   }

//   int calculateScoreForQuestion7(String userAnswer) {
//     int numOfAnimals = int.tryParse(userAnswer) ?? 0;
//     if (numOfAnimals == 0) {
//       return 0;
//     } else if (numOfAnimals >= 1 && numOfAnimals <= 5) {
//       return 1;
//     } else if (numOfAnimals >= 6 && numOfAnimals <= 12) {
//       return 2;
//     } else {
//       return 3;
//     }
//   }

//   void startTimer() {
//     _isTimerButtonEnabled = false;
//     notifyListeners();
//   }

//   void nextQuestion(BuildContext context) {
//     if (_currentQuestionIndex < _questions.length - 1) {
//       // Check for specific question IDs before incrementing the index
//       if (_questions[_currentQuestionIndex].id == '4') {
//         _hasSeenInstructionForQuestion4 = false;
//       }
//       if (_questions[_currentQuestionIndex].id == '7') {
//         _hasSeenInstructionForQuestion7 = false;
//       }
//       _currentQuestionIndex++;
//       _selectOption = null;
//     } else {
//       endSurvey(context);
//     }
//     notifyListeners();
//   }

//   void endSurvey(BuildContext context) {
//     _surveyEnded = true;
//     notifyListeners();
//     // Use Navigator to navigate to SurveyResultScreen
//     Navigator.pushNamed(context, '/surveyResultScreen');
//   }

//   // Method to reset the survey and start over
//   void restartSurvey() {
//     _currentQuestionIndex = 0;
//     _userResponses.clear();
//     _selectOption = null;
//     _hasSeenInstructionForQuestion4 = false;
//     _hasSeenInstructionForQuestion7 = false;
//     _surveyEnded = false;
//     _hasSeenFinishInstruction = false;
//     _totalScore = 0;
//     _isTimerButtonEnabled = true;
//     notifyListeners();
//   }
// }
