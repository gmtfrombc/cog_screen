import 'package:cog_screen/data/survey_data.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/providers/criteria_provider.dart';
import 'package:cog_screen/screens/advice_screen.dart';
import 'package:cog_screen/screens/criteria_screen.dart';
import 'package:cog_screen/screens/home_screen.dart';
import 'package:cog_screen/screens/survey_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      // Change this to MultiProvider
      providers: [
        ChangeNotifierProvider(
          create: (context) => SurveyProvider(
            questions: hardcodedQuestions,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CriteriaProvider(), // Add your CriteriaProvider
        ),
        // Add other global providers here if needed in the future
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cognitive Screening Tool',
      initialRoute: '/',
      routes: {
        '/survey': (context) => const SurveyScreen(),
        '/criteria': (context) => const CriteriaScreen(),
        '/advice': (context) => const AdviceScreen(),
      },
      home: const HomeScreen(),
    );
  }
}
