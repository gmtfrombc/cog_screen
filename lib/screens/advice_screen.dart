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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: verticalMargin,
          ),
          const SectionTitle(
            title: 'Tools to Support Brain Health',
            icon: Icons.medical_services,
            margin: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                child: Text(
                  'Below are options for assessing and improving memory and brain health.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              _buildMemoryEnhancementCard(context),
              _buildCogHealthCard(context),
            ],
          ),
          const SizedBox(height: 10),
          const SectionTitle(
            title: 'Maintaining Brain Health',
            icon: Icons.medical_services,
            margin: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Text(
              'Here are links to content for strategies on lifestyle and integrated options for brain health.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 3 / 2,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCard(
                    context,
                    'Understanding Cognitive Health',
                    AppConstants.understandingCognitiveHealth,
                    '/comingsoon',
                    'lib/assets/images/brain_health_2.jpeg'),
                _buildCard(
                    context,
                    'Essential Oils, Memory, and Cognitive Health',
                    AppConstants.essentialOils,
                    '/essentialOils',
                    'lib/assets/images/dT_EO2.jpeg'),
                _buildCard(
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
    );
  }

  Widget _buildCard(BuildContext context, String title, String description,
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

  Widget _buildCogHealthCard(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 180),
      child: Container(
        padding: cardPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: AppTheme.cardGradient,
        ),
        child: Card(
          shadowColor: AppTheme.secondaryColor.withOpacity(0.7),
          margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin, vertical: verticalMargin),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: AppTheme.secondaryBackgroundColor,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.healing,
                      color: Colors.black.withOpacity(
                        0.7,
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
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2.0),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  child: Text(
                    'The CogHealth Test is a simple tool for assessing memory and congitive function.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Align(
                  alignment: Alignment.bottomRight, // Align to bottom-right
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor.withOpacity(
                        0.8,
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
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Take the Test',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
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
      constraints: const BoxConstraints(minHeight: 180),
      child: Container(
        padding: cardPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: AppTheme.cardGradient,
        ),
        child: Card(
          shadowColor: AppTheme.secondaryColor.withOpacity(0.7),
          margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin, vertical: verticalMargin),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: AppTheme.secondaryBackgroundColor,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.memory,
                      color: Colors.black.withOpacity(
                        0.7,
                      ),
                      size: 35.0,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Memory Enhancement Protocol',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2.0),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  child: Text(
                    AppConstants.memoryEnhancement,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
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

  Widget _buildTextButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppTheme.primaryColor.withOpacity(
          0.8,
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
