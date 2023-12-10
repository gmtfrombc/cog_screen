import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
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
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: const CustomTextForTitle(),
        backgroundColor: AppTheme.primaryBackgroundColor,
        showLeading: true,
      ),
      showDrawer: true,
      showAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: handleFloatingActionButtonPress,
        child: const Icon(
          Icons.navigate_next,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      child: _buildCriteriaContent(context),
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
              const Icon(
                Icons.medical_services,
                color: Colors.black54,
              ),
              const SizedBox(width: 10),
              Text(
                'Medical Questionnaire',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 20,
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
                  shadowColor: AppTheme.secondaryColor.withOpacity(0.7),
                  color: AppTheme.primaryBackgroundColor,
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset:
                              const Offset(0, -2), // Changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                          12.0), // Adjust radius to your preference
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          criteria.statement,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _responseButton(context, index, true),
                            const SizedBox(width: 8),
                            // Call the new _responseButton method for the 'No' button
                            _responseButton(context, index, false),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void handleFloatingActionButtonPress() {
    final criteriaProvider =
        Provider.of<CriteriaProvider>(context, listen: false);
    if (criteriaProvider.allAnswered()) {
      _showProgressIndicator();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(
            seconds: 1,
          ),
          content: Text(
            "Please answer all questions.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  void _showProgressIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop(); // Close the progress indicator dialog
      showCompletionDialog();
    });
  }

  void showCompletionDialog() {
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

  Widget _responseButton(BuildContext context, int index, bool isYesResponse) {
    // Fetch the latest state directly inside the button builder
    final criteriaProvider =
        Provider.of<CriteriaProvider>(context, listen: true);
    bool isSelected = (isYesResponse &&
            criteriaProvider.criteriaList[index].response == true) ||
        (!isYesResponse &&
            criteriaProvider.criteriaList[index].response == false);

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : null,
        backgroundColor:
            isSelected ? Theme.of(context).colorScheme.primary : null,
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        minimumSize: const Size(44, 36),
      ),
      onPressed: () {
        final criteriaProvider =
            Provider.of<CriteriaProvider>(context, listen: false);
        criteriaProvider.setResponse(index, isYesResponse);
        _scrollToIndex(index);
      },
      child: Text(
        isYesResponse == true ? 'Yes' : 'No',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _scrollToIndex(int index) {
    double itemHeight = 120.0;
    double position = itemHeight * index;
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    if (position > maxScrollExtent) position = maxScrollExtent;

    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
