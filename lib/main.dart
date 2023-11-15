import 'package:cog_screen/data/survey_data.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/home_screen.dart';
import 'package:cog_screen/screens/survey_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SurveyProvider(
        questions: hardcodedQuestions,
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cogntive Screening Tool',
      initialRoute: '/',
      routes: {
        // '/': (context) => const HomeScreen(),
        '/survey': (context) => const SurveyScreen(),
      }, //defalut is //,
      home: const HomeScreen(),
    );
  }
}
