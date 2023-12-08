import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CogOnboardingScreen extends StatelessWidget {
  const CogOnboardingScreen({super.key});

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
                'lib/assets/images/brain_health_2.jpeg',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 2.3,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
            //top: 400,
            top: MediaQuery.of(context).size.height / 2,
            left: 0,
            right: 0,
            //bottom: 100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'The CogHealth Test',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'In this module you will be able to do stuff:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/cognitive',
                    ),
                    child: const Text('Get Started'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50, // Adjust the position as needed
            left: 10, // Adjust the position as needed
            child: IconButton(
              icon: const Icon(Icons.chevron_left, size: 40),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
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
