import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final BuildContext context;
  final AppNavigationProvider appNavigationProvider;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.context,
    required this.appNavigationProvider,
  });

  @override
  Widget build(BuildContext context) {
    String userAction = '';
    return SizedBox(
      height: 110,
      child: BottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        onTap: (index) {
          String route;
          switch (index) {
            case 0:
              userAction = 'Home';
              route = '/home';
              break;
            case 1:
              userAction = 'Results';
              route = '/allresults';
              break;
            case 2:
              userAction = 'Store';
              route = '/comingsoon';
              break;
            // Add other cases for different indices...
            default:
              route = '/';
          }
          _handleButtonClick(userAction);
          appNavigationProvider.navigateToScreen(route, context);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.store,
            ),
            label: 'Store',
          ),
        ],
      ),
    );
  }

  void _handleButtonClick(String userAction) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseService().recordUserAction(
        userId,
        'Bottom Nav Bar: $userAction',
        userAction,
      ); // Removed the navigation call from here
    } catch (e) {
      debugPrint('Error recording user action: $e');
    }
  }
}
