import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/screens/cogntive_screen.dart';
import 'package:cog_screen/screens/survey_result_screen.dart';
import 'package:cog_screen/screens/survey_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  NavBarScreenState createState() => NavBarScreenState();
}

class NavBarScreenState extends State<NavBarScreen> {
  final _screens = [
    const CognitiveScreen(),
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
