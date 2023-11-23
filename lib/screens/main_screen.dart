// main_screen.dart
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cog_screen/screens/shopping_cart_screen.dart';
import 'package:cog_screen/screens/survey_result_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cog_screen/screens/start_screen.dart';
import 'package:provider/provider.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Consumer to listen to the navigation state
    return Consumer<AppNavigationProvider>(
        builder: (context, navigationState, child) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Cognitive Screening Tool',
          backgroundColor: AppTheme.primaryBackgroundColor,
        ),
        body: IndexedStack(
          index: navigationState.currentIndex,
          children: <Widget>[
            const StartScreen(),
            SurveyResultScreen(),
            const ShoppingCartScreen(),
            // Add other screens as needed
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Results',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
          currentIndex: navigationState.currentIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            navigationState.changeIndex(index);
          },
        ),
      );
    });
  }
}
