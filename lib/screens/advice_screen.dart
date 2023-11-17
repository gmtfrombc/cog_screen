import 'package:flutter/material.dart';

class AdviceScreen extends StatelessWidget {
  const AdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brain Health 101')),
      body: ListView(
        children: const [
          Card(
            child: Text('Understanding the Importance of Cognitive Health'),
          ),
          Card(
            child: Text(
                'How Your Overall Health Influences Your Cognitive Health'),
          ),
          Card(
            child: Text('Lifestyle Measures For Supporting Cognitive Heatlh'),
          ),
          Card(
            child: Text('Integrative Health and Essential Oils'),
          ),
        ],
      ),
    );
  }
}
