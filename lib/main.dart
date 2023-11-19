import 'package:cog_screen/app_theme.dart';
import 'package:cog_screen/data/survey_data.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/providers/criteria_provider.dart';
import 'package:cog_screen/screens/cognitive_basics_screen.dart';
import 'package:cog_screen/screens/criteria_screen.dart';
import 'package:cog_screen/screens/essential_oils_screen.dart';
import 'package:cog_screen/screens/integrative_screen.dart';
import 'package:cog_screen/screens/lifestyle_screen.dart';
import 'package:cog_screen/screens/main_screen.dart';
import 'package:cog_screen/screens/protocol_screen.dart';
import 'package:cog_screen/screens/survey_result_screen.dart';
import 'package:cog_screen/screens/survey_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      // Change this to MultiProvider
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppNavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SurveyProvider(questions: hardcodedQuestions),
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
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/survey': (context) => const SurveyScreen(),
        '/criteria': (context) => const CriteriaScreen(),
        '/lifestyle': (context) => const LifestyleScreen(),
        '/integrative': (context) => const IntegrativeScreen(),
        '/essentialOils': (context) => const EssentialOilScreen(),
        '/basics': (context) => const CognitiveBasicsScreen(),
        '/protocol': (context) => const ProtocolScreen(),
        '/surveyResults': (context) => const SurveyResultScreen()
      },
    );
  }
}
