import 'package:flutter/material.dart';

class LifestyleScreen extends StatelessWidget {
  const LifestyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Lifestyle Measures for Cognitive Health')),
      body: ListView(
        children: const [
          Card(
            child: Text('Nutrition'),
          ),
          Card(
            child: Text('Activity'),
          ),
          Card(
            child: Text('Sleep'),
          ),
          Card(
            child: Text('Managing Stress'),
          ),
          Card(
            child: Text('Relationships'),
          ),
        ],
      ),
    );
  }
}
