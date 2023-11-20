import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/utilities/bottom_bar_navigator.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyResultScreen extends StatelessWidget {
  const SurveyResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appNavigationProvider = Provider.of<AppNavigationProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Results'),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<SurveyProvider>(
        builder: (context, surveyProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch to fill width
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 28,
                  bottom: 28,
                ), // Increased padding
                color: theme
                    .colorScheme.secondary, // Secondary color as background
                child: Text(
                  'Your total score is: ${surveyProvider.totalScore}/10',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 26, // Increased font size
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Would you like to learn about medically validated treatments that have been shown to support cognitive health?",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: () => _showLearnMoreSheet(context),
                  child: const Text('Learn More'),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        context: context,
        appNavigationProvider: appNavigationProvider,
      ),
    );
  }
  //other code belwo ...

  void _showLearnMoreSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => _learnMoreBottomSheet(context),
    );
  }

  Widget _learnMoreBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            AppConstants.loremIpsum,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text('I Agree'),
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                  Navigator.pushNamed(
                      context, '/advice'); // Navigate to CriteriaScreen
                },
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pop(context), // Close the bottom sheet
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.grey, // Optional: style for the cancel button
                ),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
