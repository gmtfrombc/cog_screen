import 'package:cog_screen/firebase_options.dart';
import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/content_item_provider.dart';
import 'package:cog_screen/providers/health_element_provider.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/providers/cart_provider.dart';
import 'package:cog_screen/screens/coming_soon_screen.dart';
import 'package:cog_screen/screens/home_screen.dart';
import 'package:cog_screen/screens/logins/login.dart';
import 'package:cog_screen/screens/onboarding/moduleOnboarding.dart';
import 'package:cog_screen/screens/onboarding/apponboarding_screen.dart';
import 'package:cog_screen/screens/onboarding/onboarding_welcome.dart';
import 'package:cog_screen/screens/protocol_screen.dart';
import 'package:cog_screen/screens/research_screen.dart';
import 'package:cog_screen/screens/results/allresultsscreen.dart';
import 'package:cog_screen/screens/shopping_screen.dart';
import 'package:cog_screen/screens/view_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/data/survey_data.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/cog_provider.dart';
import 'package:cog_screen/providers/criteria_provider.dart';
import 'package:cog_screen/screens/advice_screen.dart';
import 'package:cog_screen/screens/criteria_screen.dart';
import 'package:cog_screen/screens/essential_oils_screen.dart';
import 'package:cog_screen/screens/onboarding/coghealthtest_onboarding.dart';
import 'package:cog_screen/screens/results/coghealth_results_screen.dart';
import 'package:cog_screen/screens/questionnaires/coghealth_survey_screen.dart';
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
          create: (context) => CogProvider(questions: hardcodedQuestions),
        ),
        ChangeNotifierProvider(
          create: (_) => SurveyProvider(),
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
        ChangeNotifierProvider(
          create: (context) => HealthElementProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContentItemProvider(),
        )
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
        '/survey': (context) => const CogHealthSurveyScreen(),
        '/results': (context) => const CogHealthResultsScreen(),
        '/allresults': (context) => const AllResultsScreen(),
        '/surveyResultScreen': (context) => const CogHealthResultsScreen(),
        '/shoppingCart': (context) => const ShoppingScreen(),
        '/criteria': (context) => const CriteriaScreen(),
        '/essentialOils': (context) => const EssentialOilScreen(),
        '/protocol': (context) => const ProtocolScreen(),
        '/research': (context) => const ResearchScreen(),
        '/splashscreen': (context) => const SplashScreen(),
        '/comingsoon': (context) => const ComingSoonScreen(),
        '/onboarding': (context) => const AppOnboardingScreen(),
        //'/advice': (context) => const AdviceScreen(),
        '/onboardingWelcome': (context) => const OnboardingWelcomeScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/moduleOnboarding':
            if (settings.arguments is HealthElement) {
              final HealthElement element = settings.arguments as HealthElement;
              return MaterialPageRoute(
                builder: (context) => ModuleOnboarding(healthElement: element),
              );
            } else {
              return MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              );
            }
          case '/viewScreen':
            final String? url = settings.arguments as String?;
            if (url != null) {
              return MaterialPageRoute(
                builder: (context) => ViewScreen(url: url),
              );
            } else {
              return MaterialPageRoute(
                  builder: (context) => const HomeScreen());
            }
          case '/advice':
            if (settings.arguments is HealthElement) {
              final HealthElement element = settings.arguments as HealthElement;
              String moduleName = element.title.replaceAll(' ', '');
              return MaterialPageRoute(
                builder: (context) => AdviceScreen(
                    healthElement: element, moduleName: moduleName),
              );
            } else {
              return MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              );
            }
          // case '/surveyscreen':
          //   return MaterialPageRoute(
          //     builder: (context) => const SurveyScreen(),
          //   );
          default:
            // Handle other routes or return null for unhandled routes
            return null;
        }
      },
    );
  }
}
