import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllResultsScreen extends StatelessWidget {
  final String userId;

  const AllResultsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final appNavigationProvider = Provider.of<AppNavigationProvider>(
      context,
    );
    // Fetch data using FutureBuilder or similar approach
    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: const CustomTextForTitle(),
        backgroundColor: AppTheme.primaryBackgroundColor,
        showEndDrawerIcon: true,
        showLeading: true,
      ),
      showDrawer: true,
      showAppBar: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        context: context,
        appNavigationProvider: appNavigationProvider,
      ),
      child: Scaffold(
        body: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
          future: FirebaseService().getUserResults(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              var cogHealthResults = snapshot.data!['coghealth'];
              var brainHealthResults = snapshot.data!['brainhealth'];

              return Column(
                children: [
                  Expanded(
                    child: buildTestResultsSection(
                        'CogHealth Test Results', cogHealthResults),
                  ),
                  Expanded(
                    child: buildTestResultsSection(
                        'Brain Health Test Results', brainHealthResults),
                  ),
                ],
              );
            } else {
              return const Text("No results found");
            }
          },
        ),
      ),
    );
  }

  Widget buildTestResultsSection(
      String title, List<Map<String, dynamic>>? results) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: results?.length ?? 0,
            itemBuilder: (context, index) {
              var result = results![index];
              // You can format the date and score as needed
              return ListTile(
                title: Text('Score: ${result['score']}'),
                subtitle: Text('Date: ${result['date']}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
