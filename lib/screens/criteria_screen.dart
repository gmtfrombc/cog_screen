import 'package:cog_screen/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cog_screen/providers/criteria_provider.dart';
import 'package:cog_screen/app_theme.dart'; // Assuming this is where your AppTheme class is defined

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
    final criteriaProvider =
        Provider.of<CriteriaProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inclusion/Exclusion Criteria'),
      ),
      body: Consumer<CriteriaProvider>(
        builder: (context, criteriaProvider, child) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  AppConstants.medAdvice,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                ),
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
                        minHeight: 120,
                      ),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    criteria.statement,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            _responseButton(
                                context,
                                criteria.response == true,
                                'Yes',
                                index,
                                () =>
                                    criteriaProvider.setResponse(index, true)),
                            const SizedBox(
                                width: 4), // A small gap between buttons
                            _responseButton(
                                context,
                                criteria.response == false,
                                'No',
                                index,
                                () =>
                                    criteriaProvider.setResponse(index, false)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () {
          if (criteriaProvider.allAnswered()) {
            Navigator.pushNamed(context, '/advice');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please answer all questions.")),
            );
          }
        },
        child: const Icon(Icons.navigate_next),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
        ), // Further reduced padding
      ),
      onPressed: () {
        onPressed();

        // Calculate the target scroll position
        double itemHeight = 120.0; // The height of each list item
        double position = itemHeight * index;

        // Check if the calculated position exceeds the maximum scroll extent
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        if (position > maxScrollExtent) {
          position = maxScrollExtent; // Set to max scroll extent if it exceeds
        }

        // Perform the scroll
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
