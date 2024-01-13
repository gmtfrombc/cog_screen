import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/utilities/brain_constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_progress_indicator.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:cog_screen/widgets/gradient_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrainResultsScreen extends StatefulWidget {
  final String surveyType;
  const BrainResultsScreen({super.key, required this.surveyType});

  @override
  State<BrainResultsScreen> createState() => _BrainResultsScreenState();
}

class _BrainResultsScreenState extends State<BrainResultsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    String imagePath = 'lib/assets/images/memory_enhancement.png';
    final provider = Provider.of<SurveyProvider>(context, listen: false);
    final totalScore = provider.getTotalScore();
    final theme = Theme.of(context);

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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Your Brain Care Score: $totalScore/21',
                  style: theme.textTheme.titleLarge?.copyWith(fontSize: 26),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  BrainConstants.brainHealthExplanation,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: GradientImage(
                  imagePath: imagePath,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  BrainConstants.brainHealthMore,
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
              buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
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
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      setState(
                        () => _isLoading = true,
                      );
                      bool saveSuccessful = await _saveBrainHealthResults();
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
          ),
        ],
      ),
    );
  }

  Future<bool> _saveBrainHealthResults() async {
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    final brainHealthProvider =
        Provider.of<SurveyProvider>(context, listen: false);
    final firebaseService = FirebaseService();
    final totalScore = brainHealthProvider.getTotalScore();
    final userId = authProvider.currentUser?.uid ?? '';
    final surveyType = widget.surveyType;

    try {
      debugPrint('Saving results... $totalScore,for $surveyType, and user $userId');
      await firebaseService.saveBrainHealthResults(userId, totalScore, surveyType);
      return true; // Save successful
    } catch (e) {
      debugPrint('Error saving results: $e');
      return false; // Save failed
    }
  }
}
