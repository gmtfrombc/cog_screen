import 'package:flutter/material.dart';

class IntegrativeScreen extends StatelessWidget {
  const IntegrativeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrative Treatments for Brain Health'),
      ),
      body: Column(
        children: [
          const Text(
              'While a healthy lifestyle is integral to brain health...'),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/essentialOils'),
            child: const Text('Essential Oils and Cognitive Health'),
          ),
          // Additional sections as needed
        ],
      ),
    );
  }
}
