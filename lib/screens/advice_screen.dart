import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/screens/view_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:cog_screen/widgets/section_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdviceScreen extends StatefulWidget {
  final HealthElement healthElement;
  const AdviceScreen({super.key, required this.healthElement});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  final double horizontalMargin = 8.0;
  final double verticalMargin = 4.0;
  final EdgeInsets cardPadding = const EdgeInsets.all(8.0);
  final Color cardShadowColor = AppTheme.secondaryColor.withOpacity(0.7);
  final lifestylePath =
      'https://powermeacademy.com/topic/lifestyle-strategies-for-a-healthy-brain/';
  final cogPath =
      'https://powermeacademy.com/lessons/understanding-cognitive-health/';
  bool isLoading = false;
  String userId = '';
  double defaultImageSize = 250.0;
  @override
  Widget build(BuildContext context) {
    final appNavigationProvider = Provider.of<AppNavigationProvider>(
      context,
    );
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    userId = authProvider.currentUser?.uid ?? '';

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
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              ),
            )
          : _buildAdviceContent((context)),
    );
  }

  Widget _buildAdviceContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalMargin,
          vertical: verticalMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: verticalMargin,
            ),
            const SectionTitle(
              title: 'Assessments',
            ),
            SizedBox(
              height: defaultImageSize,
              width: double.infinity,
              //width: 200, // Adjust the height as needed
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildTopCard(
                    context,
                    'McCANCE Brain Care Score',
                    AppConstants.brainCareShort,
                    '/brainehealthquestionnaire',
                    'lib/assets/images/memory_health.png',
                    AppTheme.primaryColor,
                    () => Navigator.pushNamed(
                      context,
                      '/brainehealthquestionnaire',
                    ),
                  ),
                  _buildTopCard(
                    context,
                    'The CogHealth Screening Test',
                    'A short assessment of memory and cognitive function.',
                    '/cognitive',
                    'lib/assets/images/cog_health_test2.png',
                    const Color(0xE9FCAF3B),
                    () => Navigator.pushNamed(
                      context,
                      '/cognitive',
                    ),
                  ), //// Add more cards if needed
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const SectionTitle(title: 'Protocols'),
            _buildMiddleCard(
              context,
              'Memory Enhancement Protocol',
              AppConstants.memoryEnhancement,
              '/eoOnboarding',
              'lib/assets/images/memory_health.png',
              const Color(0xE9FCAF3B),
              () {
                _handleButtonClick();
                Navigator.pushNamed(context, '/eoOnboarding');
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            const SectionTitle(
              title: 'Learning Center',
            ),
            AspectRatio(
              aspectRatio: 3 / 2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildMainCard(
                      context,
                      'Essential oils, memory, and cognitive health',
                      'Learn',
                      '/essentialOils',
                      'lib/assets/images/dT_EO2.jpeg'),
                  _buildMainCard(
                      context,
                      'Basic facts about brain health',
                      '3 min',
                      '/viewScreen',
                      'lib/assets/images/brain_health_2.jpeg',
                      url: cogPath),
                  _buildMainCard(
                    context,
                    'Lifestyle strategies for a health brain',
                    '3 min',
                    '/viewScreen',
                    'lib/assets/images/brain_outdoor_dog.jpeg',
                    url: lifestylePath,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCard(BuildContext context, String title, String description,
      String route, String imagePath, Color cardColor, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: defaultImageSize,
        height: defaultImageSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: AppTheme.cardGradient,
        ),
        child: Card(
          color: cardColor,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 25,
                left: 20,
                child: SizedBox(
                  height: 80,
                  width: 220,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      //letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 70,
                right: 10,
                child: SizedBox(
                  height: 80,
                  width: 200,
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.9,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 8.0,
                bottom: 2.0,
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiddleCard(
      BuildContext context,
      String title,
      String description,
      String route,
      String imagePath,
      Color cardColor,
      void Function()? onTap) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: screenWidth - 20,
        height: 200,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('lib/assets/images/memory_protocol.jpeg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12.0),
          gradient: AppTheme.cardGradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 2), // Changes position of shadow
            ),
          ],
        ),
        child: Card(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Opacity(
                opacity: 0.0,
                child: Image.asset(
                  imagePath,
                  width: defaultImageSize,
                  height: defaultImageSize,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                //top: 25,
                left: 20,
                bottom: 20,
                child: SizedBox(
                  height: 80,
                  width: 220,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      //letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 70,
                right: 10,
                child: SizedBox(
                  height: 80,
                  width: 200,
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.9,
                    ),
                  ),
                ),
              ),
              const Positioned(
                right: 12.0,
                bottom: 12.0,
                child: Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard(
    BuildContext context,
    String title,
    String description,
    String route,
    String imagePath, {
    String? url,
  }) {
    return InkWell(
      onTap: () {
        if (url != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewScreen(url: url),
            ),
          );
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Container(
        width: 180,
        height: 250, // Set the height of the container
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: AppTheme.cardGradient,
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          shadowColor: cardShadowColor,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height:
                      250, // Ensure the image height matches the container height
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  width: 77,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white, // Border color
                      width: 0.5, // Border thickness
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0), // Add padding inside the container
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Center the contents horizontally
                      children: [
                        Icon(
                          Icons.arrow_forward_sharp,
                          color: Colors.white.withOpacity(0.9),
                          size: 18,
                        ),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            description,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 25,
                left: 20,
                child: SizedBox(
                  height: 100,
                  width: 130,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.9,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Positioned(
                right: 12.0,
                bottom: 12.0,
                child: Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleButtonClick() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseService().recordUserAction(userId, 'InterestedButton');
      // Removed the navigation call from here
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
