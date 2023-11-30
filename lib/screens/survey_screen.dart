import 'package:cog_screen/models/survey_model.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/screens/countdown_timer.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/datepicker_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({
    super.key,
  });

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose(); // Dispose the focus node
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    // final appNavigationProvider = Provider.of<AppNavigationProvider>(
    //   context,
    // );
    Widget content = _buildBody(surveyProvider, screenHeight, context);
    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: 'CogHealth',
        backgroundColor: AppTheme.primaryBackgroundColor,
        showEndDrawerIcon: false,
        showLeading: false,
      ),
      showDrawer: false,
      showAppBar: true,
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   currentIndex: appNavigationProvider.currentIndex,
      //   context: context,
      //   appNavigationProvider: appNavigationProvider,
      // ),
      child: content, // If you want to show the AppBar
    );
  }

  Widget _buildBody(
      SurveyProvider provider, double screenHeight, BuildContext context) {
    if (provider.shouldShowFinishInstruction) {
      return _buildInstructionScreen(
          context,
          "When you are finished the CogHealth Test, select: 'I am done.'",
          () => provider.seeFinishInstruction());
    }
    if (provider.shouldShowInstructionForQuestion4) {
      return _buildInstructionScreen(
          context,
          "Get your piece of blank paper.\n\nCopy a clock face with numbers and put the time at 5 minutes past 11. \n\nOnce you are done, click 'Continue'",
          () => provider.seeInstructionForQuestion4());
    }
    if (provider.shouldShowInstructionForQuestion7) {
      return _buildQuestion7Instruction(context, provider, screenHeight);
    }
    return _buildQuestionContent(
        provider.currentQuestion, provider, context, screenHeight);
  }

  Widget _buildInstructionScreen(
      BuildContext context, String instruction, VoidCallback onContinue) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            Text(instruction,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onContinue,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion7Instruction(
      BuildContext context, SurveyProvider provider, double screenHeight) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Flip over your piece of paper and when you are ready, start the timer\n\nWrite down as many animals as you can think of in 15 seconds (don't worry about spelling)",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              CountdownTimer(
                onTimerComplete: () {
                  provider.seeInstructionForQuestion7();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionContent(Question question, SurveyProvider provider,
      BuildContext context, double screenHeight) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.15),
            Text(
              question.questionText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildAnswerWidget(question, provider, context),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerWidget(
      Question question, SurveyProvider surveyProvider, BuildContext context) {
    TextInputType keyboardType = question.keyboardType;
    bool shouldShowDollarSign = question.shouldShowDollarSign;

    if (question.id == '2' || question.id == '7') {
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
                controller: _controller,
                keyboardType: keyboardType,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                decoration: shouldShowDollarSign
                    ? const InputDecoration(prefixText: '\$')
                    : const InputDecoration(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                surveyProvider.addResponse(_controller.text);
                _controller.clear();
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
