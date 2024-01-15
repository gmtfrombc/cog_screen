import 'package:cog_screen/data/survey_repository.dart';
import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/models/survey_model.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/screens/results/survey_results_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyScreen extends StatefulWidget {
  final ContentItem contentItem;
  const SurveyScreen({super.key, required this.contentItem});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  @override
  Widget build(BuildContext context) {
    final contentItem = widget.contentItem;

    final surveyProvider = Provider.of<SurveyProvider>(context, listen: false);
    final surveyData =
        SurveyRepository.getSurveyData(surveyProvider.surveyType!);
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
          ...category.criteria.asMap().entries.map((entry) {
            final index = entry.key;
            SurveyCriterion criterion = entry.value;
            return ListTile(
              title: Text(criterion.description),
              leading: Radio<int>(
                value: criterion.rank,
                groupValue:
                    surveyProvider.getUserResponse(category.category, index),
                onChanged: (value) => _onCriterionSelected(
                  context,
                  surveyProvider,
                  value,
                  criterion,
                  isLastCategory,
                  contentItem,
                  index,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _onCriterionSelected(
    BuildContext context,
    SurveyProvider surveyProvider,
    int? value,
    SurveyCriterion criterion,
    bool isLastCategory,
    ContentItem contentItem,
    int index,
  ) {
    final currentCategory = surveyProvider.getCurrentCategory();
    surveyProvider.setUserResponse(
        currentCategory.category, index, value ?? -1);
    surveyProvider.incrementTotalScore(value!);
    if (isLastCategory) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SurveyResultsScreen(
            surveyType: surveyProvider.surveyType!,
            contentItem: contentItem,
          ),
        ),
      );
    } else {
      surveyProvider.setUserResponse(currentCategory.category, index, -1);

      surveyProvider.incrementCategoryIndex();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SurveyScreen(
            key: ValueKey(surveyProvider.currentCategoryIndex),
            contentItem: contentItem,
          ),
        ),
      );
    }
  }
}
