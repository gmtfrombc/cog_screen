import 'package:cog_screen/models/survey_model.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/countdown_timer.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SurveyScreen extends StatelessWidget {
  SurveyScreen({
    super.key,
  });
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<SurveyProvider>(
      builder: (context, surveyProvider, child) {
        // Check if I need to show the finish instruction
        if (surveyProvider.shouldShowFinishInstruction) {
          return _buildInstructionScreen(
            context,
            "When you are finished the CogHealth Screen, select: 'I am done.'",
            () => surveyProvider.seeFinishInstruction(),
          );
        }
        // Check if we need to show instructions before question 4
        if (surveyProvider.shouldShowInstructionForQuestion4) {
          return _buildInstructionScreen(
            context,
            "Get your piece of blank paper.\n\nCopy a clock face and put the time at 5 minutes past 11. \n\nOnce you are done, click 'Continue'",
            () => surveyProvider.seeInstructionForQuestion4(),
          );
        }
        // Check if we need to show instructions before question 7
        if (surveyProvider.shouldShowInstructionForQuestion7) {
          final screenHeight = MediaQuery.of(context).size.height;

          return Scaffold(
            appBar: CustomAppBar(
              title: 'CogHealth',
              backgroundColor: AppTheme.primaryBackgroundColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.15),
                    const Text(
                      "Flip over your piece of paper.\n\nWhen you are ready, start the timer\n\nWrite down as many animals as you can think of in 15 seconds (don't worry about spelling)",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CountdownTimer(
                      onTimerComplete: () {
                        surveyProvider.seeInstructionForQuestion7();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        // If no instructions need to be shown, show the current question
        Question currentQuestion = surveyProvider.currentQuestion;
        final screenHeight = MediaQuery.of(context).size.height;

        return Scaffold(
          appBar: CustomAppBar(
            title: 'CogHealth',
            backgroundColor: AppTheme.primaryBackgroundColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.15),
                Text(
                  currentQuestion.questionText,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'CogHealth',
        backgroundColor: AppTheme.primaryBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: screenHeight * 0.15), // Adjust this value as needed
              Text(
                instruction,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: onContinue,
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerWidget(
      Question question, SurveyProvider surveyProvider, BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextInputType keyboardType = TextInputType.text; // Default type
    keyboardType = const TextInputType.numberWithOptions(
        decimal: true); // Number pad with decimal for specific question
    bool shouldShowDollarSign =
        question.id == '3'; // Replace 2 with the index of your question
    if (question.id == '2' || question.id == '7') {
      // Replace with your question ID
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_focusNode.canRequestFocus) {
          _focusNode.requestFocus();
        }
      });
    }
    switch (question.type) {
      case QuestionType.numeric:
        return Column(
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                focusNode: _focusNode,
                controller: controller, // Use the controller
                keyboardType: keyboardType,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                decoration: shouldShowDollarSign
                    ? const InputDecoration(prefixText: '\$')
                    : const InputDecoration(), // Use the boolean here
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                surveyProvider
                    .addResponse(controller.text); // Add user response
                if (surveyProvider.isLastQuestion) {
                  Provider.of<AppNavigationProvider>(context, listen: false)
                      .changeIndex(1);
                } else {
                  surveyProvider.nextQuestion(context);
                }
              },
            ),
          ],
        );
      case QuestionType.yesNo:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                // Process Yes answer
                surveyProvider.addResponse('Yes');
                surveyProvider.nextQuestion(context);
              },
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                // Process No answer
                surveyProvider.addResponse('No');
                surveyProvider.nextQuestion(context);
              },
            ),
          ],
        );
      case QuestionType.multipleChoice:
        return _buildMultipleChoice(question, surveyProvider, context);
      case QuestionType.date: // Add this case
        return _buildDatePicker(question, surveyProvider, context);
    }
  }

  Widget _buildMultipleChoice(
      Question question, SurveyProvider surveyProvider, BuildContext context) {
    return Column(
      children: [
        ...question.options!.map((option) {
          return RadioListTile<String>(
            title: Text(
              option,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.black),
            ),
            value: option,
            groupValue: surveyProvider.selectedOption,
            onChanged: (value) {
              if (value != null) {
                surveyProvider.selectOption(value);
              }
            },
          );
        }),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: () {
            // Make sure an option is selected before allowing the user to submit
            if (surveyProvider.selectedOption != null) {
              surveyProvider.addResponse(surveyProvider.selectedOption!);
              // Delay the call to nextQuestion by 1 frame
              Future.delayed(Duration.zero, () {
                surveyProvider.nextQuestion(context);
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildDatePicker(
      Question question, SurveyProvider surveyProvider, BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text(
          'Select Date',
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return DatePickerBottomSheet(
                onConfirm: (selectedDate) {
                  String formattedDate =
                      DateFormat('MM/dd/yyyy').format(selectedDate);
                  surveyProvider.addResponse(formattedDate);
                  surveyProvider.nextQuestion(context);
                  Navigator.pop(context); // Close the bottom sheet
                },
              );
            },
          );
        },
      ),
    );
  }
}

class DatePickerBottomSheet extends StatefulWidget {
  final Function(DateTime) onConfirm;

  const DatePickerBottomSheet({super.key, required this.onConfirm});

  @override
  DatePickerBottomSheetState createState() => DatePickerBottomSheetState();
}

class DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  DateTime selectedDate = DateTime.now();
  bool dateSelected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(2020, 1, 1),
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate = newDate;
                  dateSelected = true;
                },
                minimumYear: 2000,
                maximumYear: 2025,
              ),
            ),
          ),
          ElevatedButton(
            child: const Text('Confirm'),
            onPressed: () {
              if (!dateSelected) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Date Selection'),
                      content: const Text('Please select a date.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                widget.onConfirm(selectedDate);
              }
            },
          ),
        ],
      ),
    );
  }
}
