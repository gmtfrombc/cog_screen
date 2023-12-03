import 'package:cog_screen/models/survey_model.dart';
import 'package:intl/intl.dart';

List<Question> hardcodedQuestions = [
  Question(
    id: "1",
    questionText: "Question 1: What is today’s date?",
    type: QuestionType.date,
    correctAnswer:
        DateFormat('MM/dd/yyyy').format(DateTime.now()), // Current date
  ),
  Question(
    id: "2",
    questionText: r"Question 2: How many 20 cent pieces are in $2.40?",
    type: QuestionType.numeric,
    correctAnswer: "12",
  ),
  Question(
    id: "3",
    questionText:
        r"Question 3: If you are buying $13.40 of groceries how much change do you receive back from a $20 bill?",
    type: QuestionType.numeric,
    correctAnswer: "6.60",
  ),
  Question(
    id: "4",
    questionText: "Question 4: Does your clock have a face with numbers?",
    type: QuestionType.yesNo,
    correctAnswer: "Yes",
  ),
  Question(
    id: "5",
    questionText: "Question 5: Are the hands pointing at 1 and 11?",
    type: QuestionType.yesNo,
    correctAnswer: "Yes",
  ),
  Question(
    id: "6",
    questionText:
        "Question 6; Is the long hand pointing at 1 and the short hand pointing at 11?",
    type: QuestionType.yesNo,
    correctAnswer: "Yes",
  ),
  // Question 7 requires custom scoring logic due to its range-based answer
  Question(
    id: "7",
    questionText: "Question 7: How many animals did you write down?",
    type: QuestionType.numeric,
    correctAnswer: null, // Custom scoring logic required
  ),
  Question(
    id: "8",
    questionText:
        "Question 8: Are you finished? (select the correct answer below)",
    type: QuestionType.multipleChoice,
    options: [
      "Yes I’m finished",
      "I’m done",
      "I am finished",
      "I am done",
      "Yes I’m done"
    ],
    correctAnswer: "I am done",
  ),
];
