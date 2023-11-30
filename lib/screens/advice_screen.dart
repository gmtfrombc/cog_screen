import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdviceScreen extends StatelessWidget {
  const AdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appNavigationProvider = Provider.of<AppNavigationProvider>(
      context,
    );
    Widget content = Column(
      children: [
        const SizedBox(height: 20), // Add some space above the title (20px
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Strategies for Supporting Your Cognitive Health',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              _buildCard(
                  context,
                  'Understanding Cognitive Health',
                  AppConstants.understandingCognitiveHealth,
                  '/basics',
                  'lib/assets/images/brain_food.jpeg'),
              _buildCard(
                  context,
                  'Lifestyle Strategies for a Health Brain',
                  AppConstants.lifestyleStrategies,
                  '/lifestyle',
                  'lib/assets/images/brain_outdoor_dog.jpeg'),
              _buildCard(
                  context,
                  'Essential Oils, Memory, and Cognitive Health',
                  AppConstants.essentialOils,
                  '/essentialOils',
                  'lib/assets/images/dT_EO2.jpeg'),
            ],
          ),
        ),
      ],
    );
    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: 'CogHealth',
        backgroundColor: AppTheme.primaryBackgroundColor,
        showEndDrawerIcon: true,
        showLeading: true,
      ),
      showDrawer: true,
      showAppBar: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        context: context,
        appNavigationProvider: appNavigationProvider,
      ),
      child: content, // If you want to show the AppBar
    );
  }

  Widget _buildCard(BuildContext context, String title, String description,
      String route, String imagePath) {
    return Card(
      elevation: 4.0,
      color: AppTheme.primaryBackgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center items vertically
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center text vertically
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Opacity(
                opacity: 0.7, // Adjust opacity as needed
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: 80, // Set a fixed width for the image
                    height: 90, // Set a fixed height for the image
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.chevron_right, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
