import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_progress_indicator.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:cog_screen/widgets/gradient_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CogHealthResultsScreen extends StatefulWidget {
  const CogHealthResultsScreen({super.key});

  @override
  State<CogHealthResultsScreen> createState() => _CogHealthResultsScreenState();
}

class _CogHealthResultsScreenState extends State<CogHealthResultsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    String imagePath = 'lib/assets/images/cog_health_start2.png';
    final theme = Theme.of(context);
    final appNavigationProvider = Provider.of<AppNavigationProvider>(
      context,
    );
    Widget content = Consumer<SurveyProvider>(
      builder: (context, surveyProvider, child) {
        String resultText = surveyProvider.totalScore == 0
            ? 'Complete the CogHealth Screen'
            : 'Your CogHealth Screening Score: ${surveyProvider.totalScore}/10';
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment:
              CrossAxisAlignment.center, // Stretch to fill width
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                resultText,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 28),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                AppConstants.cogHealthExplanation,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Center(
              child: GradientImage(
                imagePath: imagePath,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                AppConstants.cogHealthMore,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _buildButtons(context),
          ],
        );
      },
    );
    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: const CustomTextForTitle(),
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

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {
                // Navigate to AdviceScreen and reset the survey
                Navigator.pushNamed(context, '/advice');
                Provider.of<SurveyProvider>(context, listen: false)
                    .restartSurvey();
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                side: BorderSide(
                    color: AppTheme.secondaryColor,
                    width: 1.0), // Border color and width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
              child: const Text('No thanks'),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButtonTheme.of(context).style,
            onPressed: _isLoading
                ? null
                : () async {
                    setState(
                      () => _isLoading = true,
                    );
                    bool saveSuccessful = await _saveCogHealthResults();
                    if (saveSuccessful && mounted) {
                      Navigator.pushNamed(context, '/advice');
                      Provider.of<SurveyProvider>(context, listen: false)
                          .restartSurvey();
                    }
                    if (mounted) {
                      setState(() => _isLoading = false);
                    }
                  },
            child: _isLoading
                ? const CustomProgressIndicator(size: 20.0)
                : const Text('Save my results'),
          ),
        ],
      ),
    );
  }

  Future<bool> _saveCogHealthResults() async {
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    final surveyProvider = Provider.of<SurveyProvider>(context, listen: false);
    final firebaseService = FirebaseService();
    final totalScore = surveyProvider.totalScore;
    final userId = authProvider.currentUser?.uid ?? '';

    try {
      await firebaseService.saveCogHealthResults(userId, totalScore);
      return true; // Save successful
    } catch (e) {
      debugPrint('Error saving results: $e');
      return false; // Save failed
    }
  }
}
