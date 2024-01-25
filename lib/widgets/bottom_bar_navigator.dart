import 'package:cog_screen/providers/app_navigation_state.dart';
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
    return SizedBox(
      height: 110,
      child: BottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        onTap: (index) {
          String route;
          switch (index) {
            case 0:
              route = '/home';
              break;
            case 1:
              route = '/allresults';
              break;
            case 2:
              route = '/comingsoon';
              break;
            // Add other cases for different indices...
            default:
              route = '/';
          }
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
          // Add other items here...
        ],
        //selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
