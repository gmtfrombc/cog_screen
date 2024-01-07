import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/cog_provider.dart';
import 'package:cog_screen/screens/questionnaires/coghealth_survey_screen.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:cog_screen/widgets/gradient_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CognitiveScreen extends StatelessWidget {
  const CognitiveScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String imagePath = 'lib/assets/images/cog_health_start2.png';
    final appNavigationProvider = Provider.of<AppNavigationProvider>(
      context,
    );
    final surveyProvider = Provider.of<CogProvider>(context);

    Widget content = Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 10), // Add some space above the title (20px
            GradientImage(
              imagePath: imagePath,
            ),
            const SizedBox(height: 40),
            Text(
              'The CogHealth Test',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: GoogleFonts.roboto().fontFamily,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Text(
                  "When you are ready, select 'Begin'",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButtonTheme.of(context).style,
                  onPressed: () {
                    // Assuming elements[0] is your brain health element
                    HealthElement brainHealthElement = elements[0];

                    // Set the currentHealthElement in CogProvider
                    Provider.of<CogProvider>(context, listen: false)
                        .setCurrentHealthElement(brainHealthElement);

                    // Restart the survey and navigate to the survey screen
                    surveyProvider.restartSurvey();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CogHealthSurveyScreen(),
                      ),
                    );
                  },
                  child: const Text('Begin'),
                ),
              ],
            ),
          ],
        ),
      ),
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
}
