import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/survey_screen.dart';
import 'package:cog_screen/utilities/bottom_bar_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('Building HomeScreen');
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Take the Cognitive Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
