import 'package:flutter/material.dart';

class AdviceScreen extends StatelessWidget {
  const AdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brain Health 101')),
      body: ListView(
        padding: const EdgeInsets.all(8.0), // Add padding around the list
        children: [
          _buildCard(
            context,
            'Understanding the Importance of Cognitive Health',
            '/basics',
          ),
          _buildCard(
            context,
            'Lifestyle Measures for Cognitive Health',
            '/lifestyle',
          ),
          _buildCard(
            context,
            'Integrative Health and Essential Oils',
            '/integrative',
          ),
          // ... more cards as needed ...
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String text, String route) {
    return Card(
      elevation: 4.0, // Adds a slight shadow
      margin:
          const EdgeInsets.symmetric(vertical: 8.0), // Spacing between cards
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding inside the card
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18, // Larger font size
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
        ),
      ),
    );
  }
}
