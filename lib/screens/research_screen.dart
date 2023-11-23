import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ResearchScreen extends StatelessWidget {
  const ResearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'CogHealth',
        backgroundColor: AppTheme.primaryBackgroundColor,
        showLeading: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Research Studies '),
          ],
        ),
      ),
    );
  }
}
