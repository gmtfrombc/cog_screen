import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/survey_screen.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/gradient_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String imagePath = 'lib/assets/images/cog_health_start2.png';
    final appNavigationProvider = Provider.of<AppNavigationProvider>(
      context,
    );
    final surveyProvider = Provider.of<SurveyProvider>(context);
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40), // Add some space above the title (20px
          GradientImage(
            imagePath: imagePath,
          ),
          const SizedBox(height: 40),
          const Text(
            'Take the CogHealth Test',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              AppConstants.cogHealthStart,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "When you are ready, select 'Begin'",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              surveyProvider.restartSurvey();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SurveyScreen(),
                ),
              );
            },
            child: const Text('Begin'),
          ),
        ],
      ),
    );

    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: 'CogHealth',
        backgroundColor: AppTheme.primaryBackgroundColor,
        showEndDrawerIcon: true,
        showLeading: false,
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
}
