import 'package:cog_screen/app_theme.dart';
import 'package:cog_screen/providers/criteria_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CriteriaScreen extends StatelessWidget {
  const CriteriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CriteriaProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Inclusion/Exclusion Criteria'),
          ),
          body: ListView.builder(
            itemCount: provider.criteriaList.length,
            padding: const EdgeInsets.only(bottom: 80), // Padding for FAB
            itemBuilder: (context, index) {
              var criteria = provider.criteriaList[index];
              return Card(
                // Increased bottom padding for each card
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
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
                    _responseButton(context, criteria.response == true, 'Yes',
                        () => provider.setResponse(index, true)),
                    const SizedBox(width: 4), // A small gap between buttons
                    _responseButton(context, criteria.response == false, 'No',
                        () => provider.setResponse(index, false)),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme.secondaryColor,
            onPressed: () {
              if (provider.allAnswered()) {
                Navigator.pushNamed(context, '/advice');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please answer all questions.")),
                );
              }
            },
            child: const Icon(Icons.navigate_next),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  Widget _responseButton(BuildContext context, bool isSelected, String label,
      VoidCallback onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : null,
        backgroundColor:
            isSelected ? Theme.of(context).colorScheme.primary : null,
        padding: const EdgeInsets.symmetric(
            horizontal: 2.0), // Further reduced padding
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
