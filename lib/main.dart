import 'package:cog_screen/screens/protocol_screen.dart';
import 'package:cog_screen/screens/research_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/data/survey_data.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/providers/criteria_provider.dart';
import 'package:cog_screen/screens/advice_screen.dart';
import 'package:cog_screen/screens/cognitive_basics_screen.dart';
import 'package:cog_screen/screens/criteria_screen.dart';
import 'package:cog_screen/screens/essential_oils_screen.dart';
import 'package:cog_screen/screens/lifestyle_screen.dart';
import 'package:cog_screen/screens/shopping_cart_screen.dart';
import 'package:cog_screen/screens/start_screen.dart';
import 'package:cog_screen/screens/survey_result_screen.dart';
import 'package:cog_screen/screens/survey_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cog_screen/screens/splashscreen.dart'; // Import your SplashScreen widget

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure everything is initialized
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AppNavigationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SurveyProvider(questions: hardcodedQuestions),
          ),
          ChangeNotifierProvider(
            create: (context) => CriteriaProvider(),
          ),
          // Add other global providers here if needed
        ],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cognitive Screening Tool',
      theme: AppTheme.lightTheme,
      initialRoute:
          '/splashscreen', // Set the initial route to the splash screen
      routes: {
        '/': (context) => const StartScreen(),
        '/survey': (context) => const SurveyScreen(),
        '/results': (context) => const SurveyResultScreen(),
        '/surveyResultScreen': (context) => const SurveyResultScreen(),
        '/basics': (context) => const CognitiveBasicsScreen(),
        '/shoppingCart': (context) => const ShoppingCartScreen(),
        '/criteria': (context) => const CriteriaScreen(),
        '/advice': (context) => const AdviceScreen(),
        '/lifestyle': (context) => const LifestyleScreen(),
        '/essentialOils': (context) => const EssentialOilScreen(),
        '/protocol': (context) => const ProtocolScreen(),
        '/research': (context) => const ResearchScreen(),
        '/splashscreen': (context) =>
            const SplashScreen(), // Add your SplashScreen route
      },
    );
  }
}
