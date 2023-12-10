import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BrainCareOnboardingScreen extends StatelessWidget {
  const BrainCareOnboardingScreen({super.key});

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
      showAppBar: false,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Image.asset(
                'lib/assets/images/brain_health_onboarding.jpeg',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 2,
              ),
            ),
          ),
          Positioned(
            //top: 400,
            top: 2 * MediaQuery.of(context).size.height / 4,
            left: 0,
            right: 0,
            //bottom: 100,
            child: Padding(
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
                      const Text(
                        'In this module you will be able to:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildBulletItem(
                          'Perform a brief cognitive screen called the CogHealth Test.'),
                      _buildBulletItem(
                          'Explore strategies to improve memory and cognitive health.'),
                      _buildBulletItem(
                          'Learn about the exciting research on essential oils and cognitive health.'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButtonTheme.of(context).style,
                    onPressed: () => Navigator.pushNamed(context, '/advice'),
                    child: const Text('Get Started'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50, // Adjust the position as needed
            child: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                size: 40,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildBulletItem(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, left: 16.0),
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
