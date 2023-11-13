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
    switch (question.type) {
      case QuestionType.numeric:
        return TextField(
          keyboardType: TextInputType.number,
          onSubmitted: (value) {
            // Process numeric input
          },
        );
      case QuestionType.yesNo:
        return Column(
          children: [
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                // Process Yes answer
              },
            ),
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                // Process No answer
              },
            ),
          ],
        );
      case QuestionType.multipleChoice:
        return _buildMultipleChoice(question, surveyProvider);
      default:
        return const Text('Unknown question type');
    }
  }

  Widget _buildMultipleChoice(
      Question question, SurveyProvider surveyProvider) {
    return ListView(
      shrinkWrap: true,
      children: question.options!.map((option) {
        return RadioListTile<String>(
          title: Text(option),
          value: option,
          groupValue: surveyProvider.selectedOption,
          onChanged: (value) {
            // Process multiple choice answer
            if (value != null) {
              surveyProvider.selectOption(value);
              // You may want to call a method to process the response here
              surveyProvider.addResponse(value);
            }
          },
        );
      }).toList(),
    );
  }
}
