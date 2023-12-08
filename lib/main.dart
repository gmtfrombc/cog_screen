import 'package:cog_screen/firebase_options.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/cart_provider.dart';
import 'package:cog_screen/screens/coming_soon_screen.dart';
import 'package:cog_screen/screens/home_screen.dart';
import 'package:cog_screen/screens/login.dart';
import 'package:cog_screen/screens/onboarding/brain_care_onboarding.dart';
import 'package:cog_screen/screens/onboarding/onboarding_screen.dart';
import 'package:cog_screen/screens/protocol_screen.dart';
import 'package:cog_screen/screens/research_screen.dart';
import 'package:cog_screen/screens/shopping_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/data/survey_data.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/providers/criteria_provider.dart';
import 'package:cog_screen/screens/advice_screen.dart';
import 'package:cog_screen/screens/criteria_screen.dart';
import 'package:cog_screen/screens/essential_oils_screen.dart';
import 'package:cog_screen/screens/coghealth_test.dart';
import 'package:cog_screen/screens/survey_result_screen.dart';
import 'package:cog_screen/screens/survey_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cog_screen/screens/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Run the app
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
        ChangeNotifierProvider(
          create: (_) => AuthProviderClass(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
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
      debugShowCheckedModeBanner: false,
      title: 'Cognitive Screening Tool',
      theme: AppTheme.lightTheme,
      initialRoute: '/splashscreen',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(), // Add your StartScreen route
        '/cognitive': (context) =>
            const CognitiveScreen(), // Add your StartScreen route
        '/survey': (context) => const SurveyScreen(),
        '/results': (context) => const SurveyResultScreen(),
        '/surveyResultScreen': (context) => const SurveyResultScreen(),
        '/shoppingCart': (context) => const ShoppingScreen(),
        '/criteria': (context) => const CriteriaScreen(),
        '/advice': (context) => const AdviceScreen(),
        '/essentialOils': (context) => const EssentialOilScreen(),
        '/protocol': (context) => const ProtocolScreen(),
        '/research': (context) => const ResearchScreen(),
        '/splashscreen': (context) => const SplashScreen(),
        '/comingsoon': (context) => const ComingSoonScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/cogtestonboarding': (context) => const CogTestOnboardingScreen(),
      },
    );
  }
}
