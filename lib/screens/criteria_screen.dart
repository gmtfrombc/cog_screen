import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cog_screen/providers/criteria_provider.dart';
import 'package:cog_screen/themes/app_theme.dart'; // Assuming this is where your AppTheme class is defined

class CriteriaScreen extends StatefulWidget {
  const CriteriaScreen({super.key});

  @override
  State<CriteriaScreen> createState() => _CriteriaScreenState();
}

class _CriteriaScreenState extends State<CriteriaScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      authProvider: Provider.of<AuthProvider>(context, listen: false),
      customAppBar: CustomAppBar(
        title: 'CogHealth',
        backgroundColor: AppTheme.primaryBackgroundColor,
        showLeading: true,
      ),
      showDrawer: true,
      showAppBar: true,
      child: _buildCriteriaContent(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () {
          // Your floating action button logic
        },
        child: const Icon(Icons.navigate_next),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _buildCriteriaContent(BuildContext context) {
    final criteriaProvider =
        Provider.of<CriteriaProvider>(context, listen: false);

    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.medical_services,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Medical Questionnaire',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 20.0,
            right: 8.0,
            bottom: 8.0,
          ),
          child: Text(
            AppConstants.medAdvice,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: criteriaProvider.criteriaList.length,
            padding: const EdgeInsets.only(
              bottom: kFloatingActionButtonMargin + 80,
            ), // Padding for FAB
            itemBuilder: (context, index) {
              dynamic criteria = criteriaProvider.criteriaList[index];
              return ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 140,
                ),
                child: Card(
                  color: AppTheme.primaryBackgroundColor,
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    // ... Container child properties ...
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showProgressIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    void _handleFloatingActionButtonPress() {
      final criteriaProvider =
          Provider.of<CriteriaProvider>(context, listen: false);
      if (criteriaProvider.allAnswered()) {
        // Your logic when all questions are answered
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please answer all questions.")),
        );
      }
    }

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop(); // Close the progress indicator dialog
      _showCompletionDialog();
    });
  }

  void _showCompletionDialog() {
    final criteriaProvider =
        Provider.of<CriteriaProvider>(context, listen: false);

    bool allNo = criteriaProvider.criteriaList
        .every((criteria) => criteria.response == false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Assessment Complete"),
        content: Text(allNo
            ? "Your assessment has been accepted, please click 'Okay' to continue."
            : "We can't approve your assessment at this time. We recommend you review your results with your primary care health provider."),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              if (allNo) {
                Navigator.pushNamed(
                    context, '/protocol'); // Navigate to the protocol screen
              } else {
                Navigator.pushNamed(context,
                    '/essentialOils'); // Navigate back to the essential oils screen
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _responseButton(BuildContext context, bool isSelected, String label,
      int index, VoidCallback onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : null,
        backgroundColor:
            isSelected ? Theme.of(context).colorScheme.primary : null,
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        minimumSize: const Size(
          44,
          36,
        ),
      ),
      onPressed: () {
        onPressed();

        double itemHeight = 120.0;
        double position = itemHeight * index;

        // Check if the calculated position exceeds the maximum scroll extent
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        if (position > maxScrollExtent) {
          position = maxScrollExtent; // Set to max scroll extent if it exceeds
        }

        _scrollController.animateTo(
          position,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
