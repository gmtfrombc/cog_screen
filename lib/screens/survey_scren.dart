import 'package:cog_screen/models/survey_model.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SurveyProvider>(
      builder: (context, surveyProvider, child) {
        Question currentQuestion = surveyProvider.currentQuestion;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Survey'),
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
                _buildAnswerWidget(currentQuestion,
                    surveyProvider), // Use Provider to manage state
                // Add navigation buttons if needed
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnswerWidget(Question question, SurveyProvider surveyProvider) {
    TextEditingController controller = TextEditingController(); // Add this line

    // ... other code ...

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
              child: const Text('Submit'),
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
}
