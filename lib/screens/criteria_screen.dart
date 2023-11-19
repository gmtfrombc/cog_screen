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
            itemBuilder: (context, index) {
              var criteria = provider.criteriaList[index];
              return ListTile(
                title: Text(criteria.statement),
                trailing: ToggleButtons(
                  isSelected: [
                    criteria.response == true,
                    criteria.response == false,
                  ],
                  onPressed: (int newIndex) {
                    provider.setResponse(index, newIndex == 0);
                  },
                  children: const [
                    Icon(Icons.thumb_up),
                    Icon(Icons.thumb_down)
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (provider.allAnswered()) {
                // Proceed to next screen if all questions are answered
                Navigator.pushNamed(context, '/advice');
              } else {
                // Show an alert or
                Navigator.pushNamed(context, '/advice');
              }
            },
            child: const Icon(Icons.navigate_next),
          ),
        );
      },
    );
  }
}
