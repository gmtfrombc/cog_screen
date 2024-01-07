import 'package:cog_screen/data/survey_repository.dart';
import 'package:cog_screen/models/survey_model.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/screens/results/braincare_results_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyScreen extends StatefulWidget {
  final String surveyType;

  const SurveyScreen({
    super.key,
    required this.surveyType,
  });

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context, listen: false);
    final surveyData = SurveyRepository.getSurveyData(widget.surveyType);
    debugPrint(
        'Current Category Index: ${surveyProvider.currentCategoryIndex}');
    debugPrint('Survey Data Length: ${surveyData.length}');
    final isLastCategory =
        surveyProvider.currentCategoryIndex == surveyData.length - 1;
    final category = surveyData[surveyProvider.currentCategoryIndex];
    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: const CustomTextForTitle(),
        backgroundColor: AppTheme.primaryBackgroundColor,
        showEndDrawerIcon: false,
        showLeading: false,
      ),
      showDrawer: false,
      showAppBar: true,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              category.category,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              category.title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          ...category.criteria.map((criterion) {
            return ListTile(
              title: Text(criterion.description),
              leading: Radio<int>(
                value: criterion.rank,
                groupValue: surveyProvider.getUserResponse(category.category),
                onChanged: (value) => _onCriterionSelected(
                    context, surveyProvider, value, criterion, isLastCategory),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _onCriterionSelected(BuildContext context, SurveyProvider surveyProvider,
      int? value, SurveyCriterion criterion, bool isLastCategory) {
    // Obtain the current category from the provider
    final currentCategory = surveyProvider.getCurrentCategory();

    // Set user response if different from existing value
    if (surveyProvider.getUserResponse(currentCategory.category) != value) {
      surveyProvider.setUserResponse(currentCategory.category, value ?? -1);
      surveyProvider.incrementTotalScore(criterion.rank);
    }

    // Check if it's the last category
    if (isLastCategory) {
      // Navigate to the results screen if it's the last category
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BrainResultsScreen(),
        ),
      );
    } else {
      // Increment the current category index for the next category
      surveyProvider.incrementCategoryIndex();

      // Navigate to the same SurveyScreen with the next category
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SurveyScreen(
            surveyType: widget.surveyType, // Pass only the surveyType
          ),
        ),
      );
    }
  }
}
