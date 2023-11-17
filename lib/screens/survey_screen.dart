import 'package:cog_screen/models/survey_model.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/survey_result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SurveyProvider>(
      builder: (context, surveyProvider, child) {
        // Check if we need to show the finish instruction
        if (surveyProvider.shouldShowFinishInstruction) {
          return _buildInstructionScreen(
            context,
            "When you are finished, select I am done",
            () => surveyProvider.seeFinishInstruction(),
          );
        }
        // Check if we need to show instructions before question 4
        if (surveyProvider.shouldShowInstructionForQuestion4) {
          return _buildInstructionScreen(
            context,
            "Copy a clock face and put the time at 10 past 11",
            () => surveyProvider.seeInstructionForQuestion4(),
          );
        }

        // Check if we need to show instructions before question 7
        if (surveyProvider.shouldShowInstructionForQuestion7) {
          return _buildInstructionScreen(
            context,
            "Count the number of animals you can think of",
            () => surveyProvider.seeInstructionForQuestion7(),
          );
        }
        if (surveyProvider.surveyEnded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (ModalRoute.of(context)!.isCurrent) {
              // Navigate to the results screen
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SurveyResultScreen(
                  totalScore: surveyProvider.totalScore,
                  onRestart: surveyProvider.restartSurvey,
                ),
              ));
            }
          });
        }
        // If no instructions need to be shown, show the current question
        Question currentQuestion = surveyProvider.currentQuestion;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Cognitive Screen'),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentQuestion.questionText,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildAnswerWidget(currentQuestion, surveyProvider, context),
                // Add navigation buttons if needed
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInstructionScreen(
      BuildContext context, String instruction, VoidCallback onContinue) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instructions"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(instruction),
            ElevatedButton(
              onPressed: onContinue,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerWidget(
      Question question, SurveyProvider surveyProvider, BuildContext context) {
    TextEditingController controller = TextEditingController(); // Add this line

    switch (question.type) {
      case QuestionType.numeric:
        return Column(
          children: [
            TextField(
              controller: controller, // Use the controller
              keyboardType: TextInputType.number,
              // Removed the onSubmitted callback
            ),
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                // Process numeric input
                surveyProvider.addResponse(controller.text);
                surveyProvider.nextQuestion();
              },
            ),
          ],
        );
      case QuestionType.yesNo:
        return Column(
          children: [
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                // Process Yes answer
                surveyProvider.addResponse('Yes');
                surveyProvider.nextQuestion();
              },
            ),
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                // Process No answer
                surveyProvider.addResponse('No');
                surveyProvider.nextQuestion();
              },
            ),
          ],
        );
      case QuestionType.multipleChoice:
        return _buildMultipleChoice(question, surveyProvider);
      case QuestionType.date: // Add this case
        return _buildDatePicker(question, surveyProvider, context);
    }
  }

  Widget _buildMultipleChoice(
      Question question, SurveyProvider surveyProvider) {
    return Column(
      children: [
        ...question.options!.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: surveyProvider.selectedOption,
            onChanged: (value) {
              if (value != null) {
                surveyProvider.selectOption(value);
              }
            },
          );
        }).toList(),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: () {
            // Make sure an option is selected before allowing the user to submit
            if (surveyProvider.selectedOption != null) {
              surveyProvider.addResponse(surveyProvider.selectedOption!);
              surveyProvider.nextQuestion();
            }
          },
        ),
      ],
    );
  }

  Widget _buildDatePicker(
      Question question, SurveyProvider surveyProvider, BuildContext context) {
    return ElevatedButton(
      child: const Text('Select Date'),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return DatePickerBottomSheet(
              onConfirm: (DateTime selectedDate) {
                String formattedDate =
                    DateFormat('MM/dd/yyyy').format(selectedDate);
                surveyProvider.addResponse(formattedDate);
                surveyProvider.nextQuestion();
                Navigator.pop(context); // Close the bottom sheet
              },
            );
          },
        );
      },
    );
  }
}

class DatePickerBottomSheet extends StatefulWidget {
  final Function(DateTime) onConfirm;

  const DatePickerBottomSheet({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  DatePickerBottomSheetState createState() => DatePickerBottomSheetState();
}

class DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(2020, 1, 1),
              onDateTimeChanged: (DateTime newDate) {
                selectedDate = newDate;
              },
              minimumYear: 2000, // Adjust as needed
              maximumYear: 2025, // Adjust as needed
            ),
          ),
          ElevatedButton(
            child: const Text('Confirm'),
            onPressed: () => widget.onConfirm(selectedDate),
          ),
        ],
      ),
    );
  }
}
