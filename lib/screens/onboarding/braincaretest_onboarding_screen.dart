import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:cog_screen/widgets/gradient_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BrainHealthScoreOnboarding extends StatelessWidget {
  const BrainHealthScoreOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final appNavigationProvider = Provider.of<AppNavigationProvider>(context);
    final theme = Theme.of(context);
    String imagePath = 'lib/assets/images/memory_enhancement.png';
    final brainHealthProvider = Provider.of<SurveyProvider>(context);
    Widget content = Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 10),
            GradientImage(imagePath: imagePath),
            Text(
              'Brain Care Score',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: GoogleFonts.roboto().fontFamily,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                AppConstants.braincareStart,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
            Text(
              "When you are ready, select 'Begin'",
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                brainHealthProvider.restartSurvey();
                debugPrint('Navigating to Brain Health Survey');
                Navigator.pushNamed(
                  context,
                  '/braincaretest',
                  arguments: {
                    'surveyType': 'Brain Health',
                  },
                );
              },
              child: const Text('Begin'),
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
      child: content,
    );
  }
}
