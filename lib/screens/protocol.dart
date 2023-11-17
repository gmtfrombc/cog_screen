import 'package:flutter/material.dart';

class ProtocolScreen extends StatelessWidget {
  const ProtocolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Improvement Protocol'),
      ),
      body: Column(
        children: [
          const Text(
              'The following is the memory improvement protocol we recommend...'),
          ListView(
            children: const [
              Text('Essential Oils: Rose, orange, eucalyptus...'),
              // Include other steps
            ],
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/survey'),
            child: const Text('Retake the Cognitive Screen'),
          ),
        ],
      ),
    );
  }
}
