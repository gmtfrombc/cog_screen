import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:cog_screen/widgets/gradient_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DynamicOnboardingScreen extends StatelessWidget {
  final ContentItem onboardingContent;
  const DynamicOnboardingScreen({
    super.key,
    required this.onboardingContent,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Building DynamicOnboardingScreen for content: ${onboardingContent.title}');

    final appNavigationProvider = Provider.of<AppNavigationProvider>(context);
    final theme = Theme.of(context);
    String imagePath = onboardingContent.surveyImage;
    Widget content = Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 10),
            GradientImage(
              imagePath: imagePath,
            ),
            const SizedBox(height: 20),
            Text(
              onboardingContent.onboardingTitle,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: GoogleFonts.roboto().fontFamily,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                onboardingContent.onboardingDescription,
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
                final surveyProvider =
                    Provider.of<SurveyProvider>(context, listen: false);
                surveyProvider.restartSurvey();
                surveyProvider.setSurveyType(onboardingContent.surveyType);
                Navigator.pushNamed(
                  context,
                  '/surveyscreen',
                  arguments: {
                    'surveyType': onboardingContent.surveyType,
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
