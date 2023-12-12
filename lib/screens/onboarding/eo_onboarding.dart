import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EOOnboardingScreen extends StatefulWidget {
  const EOOnboardingScreen({super.key});

  @override
  State<EOOnboardingScreen> createState() => _EOOnboardingScreenState();
}

class _EOOnboardingScreenState extends State<EOOnboardingScreen> {
  bool isLoading = false;
  String userId = '';
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
                'lib/assets/images/dT_EO6.jpeg',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 2.3,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.3,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Olfactory Enrichment',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppConstants.olfactoryEnrichment,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              // Define your style here
                              foregroundColor: Colors.black,
                              side: BorderSide(
                                  color: AppTheme.secondaryColor,
                                  width: 1.0), // Border color and width
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                            ),
                            child: const Text('No thanks'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButtonTheme.of(context).style,
                          onPressed: () => _handleButtonClick(),
                          child: const Text("Let's go"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40, // Adjust the position as needed
            child: IconButton(
              icon: const Icon(Icons.chevron_left, size: 40),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  void _handleButtonClick() async {
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    userId = authProvider.currentUser?.uid ?? '';
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseService().recordUserAction(userId, "Let's go button");
      if (mounted) {
        Navigator.pushNamed(context, '/criteria');
      }
    } catch (e) {
      debugPrint('Error recording user action: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
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
