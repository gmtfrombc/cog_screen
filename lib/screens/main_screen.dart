// main_screen.dart
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cog_screen/screens/home_screen.dart';
import 'package:cog_screen/screens/results/allresultsscreen.dart';
import 'package:cog_screen/screens/shopping_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Building MainScreen');
    // Use Consumer to listen to the navigation state
    return Consumer<AppNavigationProvider>(
        builder: (context, navigationState, child) {
      return Scaffold(
        appBar: CustomAppBar(
          title: const CustomTextForTitle(),
          backgroundColor: AppTheme.primaryBackgroundColor,
        ),
        body: IndexedStack(
          index: navigationState.currentIndex,
          children: <Widget>[
            const HomeScreen(),
            AllResultsScreen(),
            const ShoppingScreen(),
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
            debugPrint('Current index is: $index');
            navigationState.changeIndex(index);
          },
        ),
      );
    });
  }
}
