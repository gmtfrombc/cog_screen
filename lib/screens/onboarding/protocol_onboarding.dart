import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/health_element_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProtocolOnboardingScreen extends StatefulWidget {
  final ContentItem contentItem;
  const ProtocolOnboardingScreen({
    super.key,
    required this.contentItem,
  });

  @override
  State<ProtocolOnboardingScreen> createState() =>
      _ProtocolOnboardingScreenState();
}

class _ProtocolOnboardingScreenState extends State<ProtocolOnboardingScreen> {
  bool _isLoading = false;
  String userId = '';

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      showDrawer: true,
      showAppBar: false, // No AppBar
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Image.asset(
                    'lib/assets/images/dT_EO6.jpeg',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 2.3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.contentItem.onboardingTitle,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.contentItem.onboardingDescription,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildButtons(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return Row(
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
                padding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
              child: const Text('No thanks'),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButtonTheme.of(context).style,
            onPressed: _isLoading
                ? null
                : () async {
                    setState(
                      () => _isLoading = true,
                    );
                    await _handleButtonClick();
                  },
            child: _isLoading
                ? const CustomProgressIndicator(size: 20.0)
                : const Text('Let\'s go'),
          ),
        )
      ],
    );
  }
Future<void> _handleButtonClick() async {
    if (!mounted) return;

    final healthElementProvider =
        Provider.of<HealthElementProvider>(context, listen: false);
    final currentHealthElement = healthElementProvider.currentHealthElement;
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    final userId = authProvider.currentUser?.uid ?? '';

    if (currentHealthElement == null) {
      debugPrint("No current health element found");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final shouldNavigateToCriteria =
          await _shouldNavigateToCriteria(userId, currentHealthElement.title);
      _navigateBasedOnCondition(shouldNavigateToCriteria);
    } catch (e) {
      debugPrint('Error in _handleButtonClick: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<bool> _shouldNavigateToCriteria(
      String userId, String healthElementTitle) async {
    if (healthElementTitle != 'Brain Health') {
      return false;
    }
    final firebaseServices = FirebaseService();
    return !(await firebaseServices.checkOnboardingCompleted(
        userId, healthElementTitle));
  }

  void _navigateBasedOnCondition(bool shouldNavigateToCriteria) {
    final routeName = shouldNavigateToCriteria ? '/criteria' : '/protocol';
    Navigator.pushNamed(context, routeName);
  }



  // Future<void> _handleButtonClick() async {
  //   final healthElementProvider =
  //       Provider.of<HealthElementProvider>(context, listen: false);
  //   final currentHealthElement = healthElementProvider.currentHealthElement;
  //   final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
  //   userId = authProvider.currentUser?.uid ?? '';
  //   final firebaseServices = FirebaseService();
  //   if (currentHealthElement == null) {
  //     debugPrint("No current health element found");
  //     return;
  //   }

  //   if (!mounted) return;
  //   setState(() => _isLoading = true);

  //   try {
  //     bool onboardingCompleted = await firebaseServices
  //         .checkOnboardingCompleted(userId, currentHealthElement.title);

  //     if (!mounted) return;
  //     if (onboardingCompleted) {
  //       Navigator.pushNamed(
  //           context, '/protocol'); // Go to protocol if completed
  //     } else {
  //       await firebaseServices.recordUserAction(
  //           userId, currentHealthElement.title);
  //       if (!mounted) return;
  //       Navigator.pushNamed(context, '/criteria');
  //     }
  //   } catch (e) {
  //     debugPrint('Error in _handleButtonClick: $e');
  //   } finally {
  //     if (mounted) {
  //       setState(() => _isLoading = false);
  //     }
  //   }
  // }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 4), size.height - 60);
    var secondEndPoint = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
