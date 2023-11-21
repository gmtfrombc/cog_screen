import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/survey_screen.dart';
import 'package:cog_screen/utilities/bottom_bar_navigator.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String imagePath = 'lib/assets/images/dT_EO2.jpeg';
    final appNavigationProvider = Provider.of<AppNavigationProvider>(
      context,
    );
    final surveyProvider = Provider.of<SurveyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cognitive Screening Tool',
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40), // Add some space above the title (20px
            Opacity(
              opacity: 0.7, // Adjust opacity as needed
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Rounded corners
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 300, // Set a fixed width for the image
                  height: 200, // Set a fixed height for the image
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Take the CogHealth Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                surveyProvider.restartSurvey();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurveyScreen(),
                  ),
                );
              },
              child: const Text('Begin'),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                AppConstants.cogHealthStart,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        context: context,
        appNavigationProvider: appNavigationProvider,
      ),
    );
  }
}
