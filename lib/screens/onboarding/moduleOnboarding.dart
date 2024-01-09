// ignore_for_file: file_names
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/utilities/brain_constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cog_screen/models/health_element.dart';
import 'package:provider/provider.dart';

class ModuleOnboarding extends StatelessWidget {
  final HealthElement healthElement; // Add this line

  const ModuleOnboarding({
    super.key,
    required this.healthElement,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: const CustomTextForTitle(),
        backgroundColor:
            AppTheme.primaryBackgroundColor, // Replace with your theme color
        showEndDrawerIcon: true,
        showLeading: true,
      ),
      showDrawer: false,
      showAppBar: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Image.asset(
                'lib/assets/images/brain_health_onboarding.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 2.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to the Brain Health',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.robotoSlab().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 2.0),
                        child: Text(
                          'The Brain Health module consists of:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildBulletItem(
                          'Two assessments: the McCance Brain Care Score and the CogHealth Screening Test.'),
                      _buildBulletItem(
                          'Protocols to help improve memory and cognitive health.'),
                      _buildBulletItem(
                          'Educational content to help you understand the science behind brain health.'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButtonTheme.of(context).style,
                    onPressed: () => _showLearnMoreSheet(context),
                    child: const Text('Get Started'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLearnMoreSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) =>
          _learnMoreBottomSheet(context, healthElement),
    );
  }

  Widget _learnMoreBottomSheet(BuildContext context, HealthElement element) {
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
                  Navigator.pushNamed(context, '/advice',
                      arguments: element); // Navigate Advice
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

Widget _buildBulletItem(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20); // Start from the top left corner

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 4), size.height - 60);
    var secondEndPoint = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0); // Move to the top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
