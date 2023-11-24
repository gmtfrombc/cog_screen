import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/screens/start_screen.dart';
import 'package:cog_screen/screens/survey_result_screen.dart';
import 'package:cog_screen/screens/survey_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _screens = [
    const StartScreen(),
    const SurveyScreen(),
    const SurveyResultScreen(),
    // Add other screens here...
  ];

  @override
  Widget build(BuildContext context) {
    final appNavigationProvider = Provider.of<AppNavigationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cognitive Screening Tool'),
      ),
      body: _screens[appNavigationProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        onTap: (index) {
          appNavigationProvider.changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Start',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll),
            label: 'Survey',
          ),
          // Add other items here...
        ],
      ),
    );
  }
}
