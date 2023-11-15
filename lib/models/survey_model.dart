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

  bool validateAnswer(String userAnswer) {
    switch (type) {
      case QuestionType.numeric:
        // For numeric questions, we expect the answer to be exactly the same
        // after trimming and considering decimal places
        return userAnswer.trim() == correctAnswer.toString().trim();
      case QuestionType.yesNo:
        // For yes/no questions, the answer should match either "Yes" or "No"
        return userAnswer.trim().toLowerCase() ==
            correctAnswer.toString().toLowerCase();
      case QuestionType.multipleChoice:
        // For multiple-choice questions, the answer should be one of the options
        // and should match the correct answer
        return options != null && userAnswer.trim() == correctAnswer;
      default:
        return false;
    }
  }
}


enum QuestionType { numeric, yesNo, multipleChoice }

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
