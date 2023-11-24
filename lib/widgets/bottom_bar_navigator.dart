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
        currentIndex: currentIndex,
        onTap: (index) {
          if (currentIndex != index) {
            appNavigationProvider.changeIndex(index);
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/');
                break;
              case 1:
                Navigator.pushNamed(context, '/results');
                break;
              case 2:
                Navigator.pushNamed(context, '/shoppingCart');
                break;
              // Add other cases for other screens...
            }
          }
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
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          // Add other items here...
        ],
        selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
