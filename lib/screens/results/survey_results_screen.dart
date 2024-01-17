import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/health_element_provider.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_progress_indicator.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:cog_screen/widgets/gradient_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyResultsScreen extends StatefulWidget {
  final String surveyType;
  final ContentItem contentItem;
  const SurveyResultsScreen({
    super.key,
    required this.surveyType,
    required this.contentItem,
  });

  @override
  State<SurveyResultsScreen> createState() => _SurveyResultsScreenState();
}

class _SurveyResultsScreenState extends State<SurveyResultsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    //String imagePath = 'lib/assets/images/memory_enhancement.png';
    final surveyProvider = Provider.of<SurveyProvider>(context, listen: false);
    final totalScore = surveyProvider.getTotalScore();
    final theme = Theme.of(context);
    final possibleScore = widget.contentItem.possibleScore;
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
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.contentItem.title,
                  style: theme.textTheme.titleLarge?.copyWith(fontSize: 26),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Score: $totalScore/$possibleScore',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      debugPrint('Learn more pressed');
                      _showLearnMoreSheet(context);
                    },
                    icon: Icon(
                      Icons.info_outlined,
                      color: AppTheme.primaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  widget.contentItem.surveyResultsTop,
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
                  imagePath: widget.contentItem.surveyImage,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  widget.contentItem.surveyResultsBottom,
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
                  final healthProvider = Provider.of<HealthElementProvider>(
                    context,
                    listen: false,
                  );
                  final currentHealthElement =
                      healthProvider.currentHealthElement;
                  // Navigate to AdviceScreen and reset the survey
                  Navigator.pushNamed(
                    context,
                    '/advice',
                    arguments: currentHealthElement,
                  ); //
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
                      final healthElementProvider =
                          Provider.of<HealthElementProvider>(
                        context,
                        listen: false,
                      );

                      setState(
                        () => _isLoading = true,
                      );
                      bool saveSuccessful = await _saveSurveyResults();
                      if (saveSuccessful && mounted) {
                        Navigator.pushNamed(
                          context,
                          '/advice',
                          arguments: healthElementProvider.currentHealthElement,
                        ); //
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

  Future<bool> _saveSurveyResults() async {
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    final brainHealthProvider =
        Provider.of<SurveyProvider>(context, listen: false);
    final firebaseService = FirebaseService();
    final totalScore = brainHealthProvider.getTotalScore();
    final userId = authProvider.currentUser?.uid ?? '';
    final title = widget.contentItem.title;

    try {
      await firebaseService.saveSurveyResults(userId, totalScore, title);
      return true; // Save successful
    } catch (e) {
      debugPrint('Error saving results: $e');
      return false; // Save failed
    }
  }

  void _showLearnMoreSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to take full height
      builder: (BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;
        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: _learnMoreBottomSheet(context),
          ),
        );
      },
    );
  }

  Widget _learnMoreBottomSheet(
    BuildContext context,
  ) {
    final healthElementProvider = Provider.of<HealthElementProvider>(
      context,
      listen: false,
    );
    final currentHealthElement = healthElementProvider.currentHealthElement;
    final resultsInfo = currentHealthElement!.resultsInfo;
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
          child: Image(
            height: 200,
            image: AssetImage(
              'lib/assets/images/sleep_assessment3.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          resultsInfo!.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
          child: Text(
            resultsInfo.introText,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        for (var item in resultsInfo.resultListItems)
          ListTile(
            title: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: item.boldText,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: item.regularText,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 6.0,
          ),
          child: Text(
            resultsInfo.conclusionText,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          child: const Text('Done'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
