// main_screen.dart
import 'package:cog_screen/screens/shopping_cart_screen.dart';
import 'package:cog_screen/screens/survey_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:cog_screen/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Consumer to listen to the navigation state
    return Consumer<AppNavigationProvider>(
        builder: (context, navigationState, child) {
      debugPrint(
          'MainScreen Consumer rebuild with index: ${navigationState.currentIndex}');
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cognitive Screen'),
        ),
        body: IndexedStack(
          index: navigationState.currentIndex,
          children: const <Widget>[
            HomeScreen(),
            SurveyResultScreen(),            
            ShoppingCartScreen(),
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
          onTap:
              navigationState.navigateTo, // Update the index using the provider
        ),
      );
    });
  }
}
