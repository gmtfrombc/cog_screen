import 'package:flutter/material.dart';

class CognitiveBasicsScreen extends StatelessWidget {
  const CognitiveBasicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cognitive Screen'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Basic Information'),
          ],
        ),
      ),
    );
  }
}
