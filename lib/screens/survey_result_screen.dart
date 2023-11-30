import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/gradient_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyResultScreen extends StatelessWidget {
  const SurveyResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String imagePath = 'lib/assets/images/cog_health_start2.png';
    final theme = Theme.of(context);
    final appNavigationProvider = Provider.of<AppNavigationProvider>(
      context,
    );
    Widget content = Consumer<SurveyProvider>(
      builder: (context, surveyProvider, child) {
        String resultText = surveyProvider.totalScore == 0
            ? 'Complete the CogHealth Screen'
            : 'Your CogHealth Screening Score: ${surveyProvider.totalScore}/10';

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Stretch to fill width
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                resultText,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 28),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                AppConstants.cogHealthExplanation,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Center(
              child: GradientImage(
                imagePath: imagePath,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                AppConstants.cogHealthMore,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
                left: 20.0,
                right: 20.0,
              ),
              child: ElevatedButton(
                onPressed: () => _showLearnMoreSheet(context),
                child: const Text('Learn More'),
              ),
            ),
          ],
        );
      },
    );
    return BaseScreen(
      authProvider: Provider.of<AuthProvider>(context, listen: false),
      customAppBar: CustomAppBar(
        title: 'CogHealth',
        backgroundColor: AppTheme.primaryBackgroundColor,
        showEndDrawerIcon: true,
        showLeading: false,
      ),
      showDrawer: true,
      showAppBar: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        context: context,
        appNavigationProvider: appNavigationProvider,
      ),
      child: content, // If you want to show the AppBar
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
