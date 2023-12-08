import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCard(
                  context,
                  'Understanding Cognitive Health',
                  AppConstants.understandingCognitiveHealth,
                  '/comingsoon',
                  'lib/assets/images/brain_health_2.jpeg'),
              _buildCard(
                  context,
                  'Essential Oils, Memory, and Cognitive Health',
                  AppConstants.essentialOils,
                  '/essentialOils',
                  'lib/assets/images/dT_EO2.jpeg'),
              _buildCard(
                  context,
                  'Lifestyle Strategies for a Health Brain',
                  AppConstants.lifestyleStrategies,
                  '/comingsoon',
                  'lib/assets/images/brain_outdoor_dog.jpeg'),
            ],
          ),
        ),
      ],
    );
    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: const CustomTextForTitle(),
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
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center items vertically
          children: [
            SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: 0.9,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      child: SizedBox(
                        width:
                            double.infinity, // Takes the full width of the card
                        height: 100, // Fixed height for all images
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit
                              .cover, // Covers the area while maintaining aspect ratio
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
