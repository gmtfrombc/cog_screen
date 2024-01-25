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
          if (surveyProvider.currentCategoryIndex > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _navigateBack(context, surveyProvider),
                  child: const Row(
                    mainAxisSize: MainAxisSize
                        .min, // To keep the Row size to its children
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back, // The back arrow icon
                        size: 20, // You can adjust the size as per your need
                      ),
                      SizedBox(width: 8), // Space between icon and text
                      Text(
                        'Previous Question',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => _cancelSurvey(context, surveyProvider),
                  child: const Text('Cancel'),
                ),
              ],
            ),
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

  void _navigateBack(BuildContext context, SurveyProvider surveyProvider) {

    surveyProvider.popResponse();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SurveyScreen(
          key: ValueKey(surveyProvider.currentCategoryIndex),
          contentItem: widget.contentItem,
        ),
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


    if (value != null) {
      surveyProvider.pushResponse(surveyProvider.currentCategoryIndex, value);

      // Check if it's the last question in the survey
      if (isLastCategory) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SurveyResultsScreen(
              surveyType: surveyProvider.surveyType!,
              contentItem: contentItem,
            ),
          ),
        );
      } else {
        // Increment the category index here
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

  void _cancelSurvey(BuildContext context, SurveyProvider surveyProvider) {
    surveyProvider.restartSurvey();
    Navigator.pop(context);
  }
}
