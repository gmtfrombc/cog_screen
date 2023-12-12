import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
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
  bool isLoading = false;
  String userId = '';
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMemoryEnhancementCard(context),
                _buildCogHealthCard(context),
              ],
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
                      'lib/assets/images/brain_health_2.jpeg'),
                  _buildMainCard(
                      context,
                      'Lifestyle Strategies for a Health Brain',
                      AppConstants.lifestyleStrategies,
                      '/comingsoon',
                      'lib/assets/images/brain_outdoor_dog.jpeg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCogHealthCard(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 130,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: AppTheme.cardGradient,
        ),
        child: Card(
          shadowColor: AppTheme.primaryColor.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: AppTheme.tertiaryBackgroundColor.withOpacity(0.8),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 6.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.menu_book,
                      color: Colors.white.withOpacity(
                        0.4,
                      ),
                      size: 30.0,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'The CogHealth Test',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                //const SizedBox(height: 2.0),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 0,
                  ),
                  child: Text(
                    'A simple tool for assessing memory and congitive function.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight, // Align to bottom-right
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      side: BorderSide(
                          color: AppTheme.secondaryColor.withOpacity(0.2),
                          width: 1.0), // Border color and width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cognitive');
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.join_right_outlined,
                          color: Colors.white54,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Take the Test',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ), // Your memory enhancement card content here
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemoryEnhancementCard(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 130,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: AppTheme.cardGradient,
        ),
        child: Card(
          shadowColor: AppTheme.secondaryColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: AppTheme.tertiaryBackgroundColor.withOpacity(
            0.8,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.memory,
                      color: Colors.white.withOpacity(
                        0.4,
                      ),
                      size: 30.0,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Memory Enhancement Protocol',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.5),
                      ),
                    ),
                  ],
                ),
                //const SizedBox(height: 2.0),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 0,
                  ),
                  child: Text(
                    AppConstants.memoryEnhancement,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight, // Align to bottom-right
                  child: _buildTextButton(context, "I'm interested", () {
                    _handleButtonClick();
                  }),
                ), // Your memory enhancement card content here
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard(BuildContext context, String title, String description,
      String route, String imagePath) {
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
          onTap: () => Navigator.pushNamed(context, route),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center items vertically
            children: [
              SizedBox(
                width: 180,
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

  Widget _buildTextButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.3),
        side: BorderSide(
            color: AppTheme.secondaryColor.withOpacity(0.2),
            width: 1.0), // Border color and width
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: () {
        _handleButtonClick();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _handleButtonClick() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseService().recordUserAction(userId, 'InterestedButton');
      if (mounted) {
        Navigator.pushNamed(context, '/eoOnboarding');
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
