import 'package:cog_screen/data/braincarescore_data.dart';
import 'package:cog_screen/models/braincarescore_model.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/braincarescore_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/screens/results/braincare_results_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrainCareTestSurveyScreen extends StatelessWidget {
  final BrainCareCategory category;
  final int categoryIndex;

  const BrainCareTestSurveyScreen(
      {super.key, required this.category, required this.categoryIndex});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BrainHealthProvider>(context, listen: false);
    final isLastCategory = categoryIndex == brainCareData.length - 1;

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
                groupValue: provider.getUserResponse(category.category),
                onChanged: (value) => _onCriterionSelected(
                    context, provider, value, criterion, isLastCategory),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _onCriterionSelected(BuildContext context, BrainHealthProvider provider,
      int? value, BrainCareCriterion criterion, bool isLastCategory) {
    if (provider.getUserResponse(category.category) != value) {
      provider.setUserResponse(category.category, value ?? -1);
      provider.incrementTotalScore(criterion.rank);
    }

    if (isLastCategory) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const BrainResultsScreen()));
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BrainCareTestSurveyScreen(
            category: brainCareData[categoryIndex + 1],
            categoryIndex: categoryIndex + 1,
          ),
        ),
      );
    }
  }
}
