import 'package:cog_screen/utilities/utilities.dart';
import 'package:flutter/material.dart';

class EssentialOilScreen extends StatelessWidget {
  const EssentialOilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Essential Oils and Cognitive Health')),
      body: ListView(
        children: [
          const Card(
              child: Text(
                  'Research has backed the positive effects that essential oils have...')),
          TextButton(
            onPressed: () => openLink('URL'),
            child: const Text('Learn more about this important research'),
          ),
          // More content as necessary
        ],
      ),
    );
  }
}
