import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyResultScreen extends StatelessWidget {
  const SurveyResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Building SurveResultsScreen');
    final surveyProvider = Provider.of<SurveyProvider>(context);
    int totalScore = surveyProvider.totalScore;
    final appNavigationProvider =
        Provider.of<AppNavigationProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Results'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your total score is: $totalScore',
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () => appNavigationProvider
                  .navigateTo(5), // Updated navigation call
              child: const Text('Take the Survey Again'),
            ),
            const SizedBox(height: 20),
            const Text(
                "Would you like to learn about scientifically validated treatments that have been shown to support cognitive health?"),
            ElevatedButton(
              onPressed: () => _showLearnMoreSheet(context),
              child: const Text('Learn More'),
            ),
          ],
        ),
      ),
    );
  }

  void _showLearnMoreSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => _learnMoreBottomSheet(context),
    );
  }

  Widget _learnMoreBottomSheet(BuildContext context) {
    final appNavigationProvider =
        Provider.of<AppNavigationProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            textAlign: TextAlign.justify,
          ),
          ElevatedButton(
            child: const Text('I Agree'),
            onPressed: () {
              Navigator.pop(context);
              appNavigationProvider
                  .navigateTo(1); // Use provider for navigation
            },
          ),
        ],
      ),
    );
  }
}
