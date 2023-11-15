import 'package:cog_screen/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SurveyResultScreen extends StatelessWidget {
  final int totalScore;
  final VoidCallback onRestart;

  const SurveyResultScreen(
      {Key? key, required this.totalScore, required this.onRestart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your total score is: $totalScore',
                style: const TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () {
                onRestart(); // This should call surveyProvider.restartSurvey()
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  ModalRoute.withName('/'),
                );
              },
              child: const Text('Take the Survey Again'),
            ),
            ElevatedButton(
              onPressed: () {
                // Reset the survey and go back to the start
                onRestart();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Reset and Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
