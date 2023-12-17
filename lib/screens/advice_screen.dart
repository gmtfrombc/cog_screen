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
  const AdviceScreen({super.key});

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
              title: 'Tools to Support Brain Health',
              descrption: 'Assessment and support options.',
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
                    'The CogHealth \nScreen',
                    'A simple tool for assessing memory and cognitive function.',
                    '/cognitive',
                    'lib/assets/images/cog_health_test2.png',
                    AppTheme.tertiaryColor,
                    () => Navigator.pushNamed(
                      context,
                      '/cognitive',
                    ),
                  ),
                  _buildTopCard(
                    context,
                    'Memory Enhancement Protocol',
                    AppConstants.memoryEnhancement,
                    '/eoOnboarding',
                    'lib/assets/images/memory_health.png',
                    Colors.amber,
                    () {
                      _handleButtonClick();
                      Navigator.pushNamed(context, '/eoOnboarding');
                    },
                  ),
                  _buildTopCard(
                    context,
                    'Brain Health Questionnaire',
                    AppConstants.memoryEnhancement,
                    '/brainehealthquestionnaire',
                    'lib/assets/images/memory_enhancement.png',
                    AppTheme.primaryColor,
                    () => Navigator.pushNamed(
                      context,
                      '/brainehealthquestionnaire',
                    ),
                  ), //// Add more cards if needed
                ],
              ),
            ),
            const SectionTitle(
              title: 'Maintaining Brain Health',
              descrption: 'Lifestyle and integrated content for brain health.',
            ),
            AspectRatio(
              aspectRatio: 3 / 2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildMainCard(
                      context,
                      'Essential Oils, Memory, and Cognitive Health',
                      AppConstants.essentialOils,
                      '/essentialOils',
                      'lib/assets/images/dT_EO2.jpeg'),
                  _buildMainCard(
                      context,
                      'Understanding Cognitive Health',
                      AppConstants.understandingCognitiveHealth,
                      '/viewScreen',
                      'lib/assets/images/brain_health_2.jpeg',
                      url: cogPath),
                  _buildMainCard(
                    context,
                    'Lifestyle Strategies for a Health Brain',
                    AppConstants.lifestyleStrategies,
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
                bottom: 60,
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
              Positioned(
                right: 8.0,
                bottom: 8.0,
                child: Image.asset(
                  imagePath,
                  width: 80,
                  height: 80,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard(BuildContext context, String title, String description,
      String route, String imagePath,
      {String? url}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: AppTheme.cardGradient,
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin, vertical: verticalMargin),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        shadowColor: cardShadowColor,
        child: InkWell(
          onTap: () {
            if (url != null) {
              // Navigate to the ViewScreen with a URL
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewScreen(url: url),
                ),
              );
            } else {
              // Navigate to the given route
              Navigator.pushNamed(context, route);
            }
          },
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center items vertically
            children: [
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Opacity(
                      opacity: 0.9,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        child: SizedBox(
                          width: double
                              .infinity, // Takes the full width of the card
                          height: 100, // Fixed height for all images
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit
                                .cover, // Covers the area while maintaining aspect ratio
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ],
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
