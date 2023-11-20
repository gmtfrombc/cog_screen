import 'package:flutter/material.dart';

class AdviceScreen extends StatelessWidget {
  const AdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brain Health 101'),
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.secondary,
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'How to Support Your Cognitive Health',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                _buildCard(
                    context,
                    'Understanding the Importance of Cognitive Health',
                    '/basics',
                    'lib/assets/images/brain_food.jpeg'),
                _buildCard(context, 'Lifestyle Measures for Cognitive Health',
                    '/lifestyle', 'lib/assets/images/brain_outdoor_dog.jpeg'),
                _buildCard(
                    context,
                    'Essential Oils, Memory, and Cognitive Health',
                    '/integrative',
                    'lib/assets/images/dT_EO2.jpeg'),
                // ... more cards as needed ...
              ],
            ),
          ),
        ],
      ),
    );
  } //lib/assets/images/dT_EO1.jpeg

  Widget _buildCard(
      BuildContext context, String text, String route, String imagePath) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(
                imagePath, // Replace with your image asset
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
