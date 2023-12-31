import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Question {
  String id;
  final String questionText;
  QuestionType type;
  int scoreValue = 1;
  dynamic correctAnswer;
  List<String>? options;

  Question({
    required this.id,
    required this.questionText,
    this.scoreValue = 1,
    required this.correctAnswer,
    required this.type,
    this.options,
  });

  TextInputType get keyboardType {
    if (type == QuestionType.numeric) {
      if (id == '2' || id == '7') {
        return const TextInputType.numberWithOptions(decimal: true);
      }
      return TextInputType.number;
    }
    return TextInputType.text;
  }

  bool get shouldShowDollarSign => id == '3';
  bool validateAnswer(String userAnswer) {
    switch (type) {
      case QuestionType.numeric:
        // Special handling for the date question
        if (id == "1") {
          try {
            DateTime userDate =
                DateFormat('MM/dd/yyyy').parse(userAnswer.trim());
            DateTime currentDate = DateTime.now();
            return userDate.year == currentDate.year &&
                userDate.month == currentDate.month &&
                userDate.day == currentDate.day;
          } catch (e) {
            //parsing didn't work
            return false;
          }
        } else {
          // this is for all the other numeric questions
          return userAnswer.trim() == correctAnswer.toString().trim();
        }
      case QuestionType.yesNo:
        return userAnswer.trim().toLowerCase() ==
            correctAnswer.toString().toLowerCase();
      case QuestionType.multipleChoice:
        return options != null && userAnswer.trim() == correctAnswer;
      default:
        return false;
    }
  }
}

enum QuestionType { numeric, yesNo, multipleChoice, date }

class UserResponse {
  String questionId;
  dynamic userAnswer;
  UserResponse({
    required this.userAnswer,
    required this.questionId,
  });
}

class TestSession {
  int currentQuestionIndex;
  int totalScore;
  List<UserResponse> userResponses;
  List<Question> questions;

  TestSession({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.totalScore = 0,
    List<UserResponse>? userResponses,
  }) : userResponses = userResponses ?? [];

  int calculateScoreForQuestion7(String userAnswer) {
    int numOfAnimals = int.tryParse(userAnswer) ?? 0;
    if (numOfAnimals <= 0) {
      return 0;
    } else if (numOfAnimals <= 3) {
      return 1;
    } else if (numOfAnimals <= 6) {
      return 2;
    } else {
      return 3;
    }
  }

  void updateScore(Question question, String userAnswer) {
    if (question.id == "7") {
      totalScore += calculateScoreForQuestion7(userAnswer);
    } else if (question.validateAnswer(userAnswer)) {
      totalScore += question.scoreValue;
    }
  }
}
