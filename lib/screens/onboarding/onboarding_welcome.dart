import 'dart:math';

import 'package:cog_screen/models/onboarding_model.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/utilities/brain_constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnboardingWelcomeScreen extends StatefulWidget {
  const OnboardingWelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingWelcomeScreenState createState() =>
      _OnboardingWelcomeScreenState();
}

class _OnboardingWelcomeScreenState extends State<OnboardingWelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late final List<OnboardingModel> onboardingModelList;
  @override
  void initState() {
    super.initState();
    onboardingModelList =
        onboardingData; // Assuming onboardingData is your data source
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: const CustomTextForTitle(),
        backgroundColor:
            AppTheme.primaryBackgroundColor, // Replace with your theme color
        showEndDrawerIcon: true,
        showLeading: false,
      ),
      showDrawer: false,
      showAppBar: false,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: 3, // Total number of pages
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return buildPageContent(index, screenHeight);
            },
          ),
          if (_currentPage < 2)
            Positioned(
              bottom: 20,
              right: 20,
              child: IconButton(
                color: AppTheme.secondaryColor,
                icon: const Icon(Icons.arrow_forward),
                iconSize: 40,
                onPressed: () {
                  if (_currentPage < 2) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.pushNamed(context, '/home');
                  }
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget buildPageContent(int index, double screenHeight) {
    String imagePath = onboardingModelList[index].imagePath;
    String onboardingDescription = onboardingModelList[index].description;

    return Column(
      children: [
        const SizedBox(height: 100),
        LayoutBuilder(
          builder: (context, constraints) {
            double aspectRatio = 4 / 3; // Adjust as needed
            double idealHeight = constraints.maxWidth / aspectRatio;

            // Increase the height proportionally
            double maxHeight =
                screenHeight * 0.8; // Adjust this value as needed

            // Ensure the height does not exceed maxHeight while maintaining aspect ratio
            double finalHeight = min(idealHeight, maxHeight);

            return SizedBox(
              width: constraints.maxWidth, // Full width of the parent container
              height:
                  finalHeight, // Height adjusted based on aspect ratio and maxHeight
              child: Image.asset(imagePath, fit: BoxFit.contain),
            );
          },
        ),

        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  onboardingDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 0.5,
                    fontFamily: GoogleFonts.robotoSlab().fontFamily,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (index == 2) // Show the button only on the last page
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: () => _showLearnMoreSheet(context),
              child: const Text("Onward!"),
            ),
          ),
        const SizedBox(height: 20), // Additional space, adjust as needed
      ],
    );
  }

  void _showLearnMoreSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => _learnMoreBottomSheet(context),
    );
  }

  Widget _learnMoreBottomSheet(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            BrainConstants.loremIpsum,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text('I Agree'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/home',
                  ); // Navigate Advice
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                }, // Close the bottom sheet
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.grey, // Optional: style for the cancel button
                ),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
