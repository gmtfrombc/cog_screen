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
        automaticallyImplyLeading: false,
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
            const SizedBox(
              height: 20,
            ),
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
      builder: (BuildContext context) {
        return _learnMoreBottomSheet(context);
      },
    );
  }

  Widget _learnMoreBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.",
            textAlign: TextAlign.justify,
          ),
          ElevatedButton(
            child: const Text('I Agree'),
            onPressed: () {
              Navigator.pop(context);
              _navigateToCriteriaScreen(context);
            },
          ),
        ],
      ),
    );
  }

  void _navigateToCriteriaScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(
        '/criteria'); // Assuming you have set up a named route for CriteriaScreen
  }
}
