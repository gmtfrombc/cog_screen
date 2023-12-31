import 'package:cog_screen/models/cog_model.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/cog_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/screens/countdown_timer.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:cog_screen/widgets/datepicker_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CogHealthSureveyScreen extends StatefulWidget {
  const CogHealthSureveyScreen({
    super.key,
  });

  @override
  State<CogHealthSureveyScreen> createState() => _CogHealthSureveyScreenState();
}

class _CogHealthSureveyScreenState extends State<CogHealthSureveyScreen> {
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
    final surveyProvider = Provider.of<CogProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;

    Widget content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: _buildBody(surveyProvider, screenHeight, context),
    );

    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: const CustomTextForTitle(),
        backgroundColor: AppTheme.primaryBackgroundColor,
        showEndDrawerIcon: false,
        showLeading: false,
      ),
      showDrawer: false,
      showAppBar: true,
      child: content, // If you want to show the AppBar
    );
  }

  Widget _buildBody(
      CogProvider provider, double screenHeight, BuildContext context) {
    if (provider.shouldShowFinishInstruction) {
      return _buildInstructionScreen(
        context,
        "When you are finished the CogHealth Test, you will see five options.\n\nRemember to select: 'I am done.'",
        () => provider.seeFinishInstruction(),
      );
    }
    if (provider.shouldShowInstructionForQuestion4) {
      return _buildInstructionScreen(
        context,
        "Get your piece of blank paper.\n\nCopy a clock face with numbers and put the time at 5 minutes past 11. \n\nWhen you are done, click 'Continue'",
        () => provider.seeInstructionForQuestion4(),
      );
    }
    if (provider.shouldShowInstructionForQuestion7) {
      return _buildQuestion7Instruction(context, provider, screenHeight);
    }
    return _buildQuestionContent(
      provider.currentQuestion,
      provider,
      context,
      screenHeight,
    );
  }

  TextStyle _standardTextStyle() {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  Widget _buildInstructionScreen(
      BuildContext context, String instruction, VoidCallback onContinue) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0), // Consistent horizontal padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            Text(instruction,
                style: _standardTextStyle(), textAlign: TextAlign.center),
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
      BuildContext context, CogProvider provider, double screenHeight) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 120,
              ),
              Text(
                "Flip over your piece of paper. When you are ready, start the timer below.\n\nWrite down as many animals as you can think of in 15 seconds (don't worry about spelling)",
                style: _standardTextStyle(),
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

  Widget _buildQuestionContent(Question question, CogProvider provider,
      BuildContext context, double screenHeight) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.15),
            Text(
              question.questionText,
              style: _standardTextStyle(),
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
      Question question, CogProvider surveyProvider, BuildContext context) {
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
      Question question, CogProvider surveyProvider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
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
          const SizedBox(height: 20),
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
      ),
    );
  }

  Widget _buildDatePicker(
      Question question, CogProvider surveyProvider, BuildContext context) {
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
