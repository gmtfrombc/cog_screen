import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  String userId = '';

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          _buildTop(context), // Your existing HomeScreen UI
          if (isLoading) _buildLoadingOverlay() // Overlay if loading
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
        child: Center(
          child: CustomProgressIndicator(
            color: AppTheme.primaryColor,
          ), // Loading indicator
        ),
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BaseScreen(
        authProvider: Provider.of<AuthProviderClass>(context, listen: false),
        customAppBar: CustomAppBar(
          title: Image.asset(
            'lib/assets/images/pm_icon_full.png',
            fit: BoxFit.cover,
            height: 40,
          ),
          backgroundColor: AppTheme.primaryBackgroundColor,
          showEndDrawerIcon: true,
          showLeading: false,
        ),
        showDrawer: true,
        showAppBar: true,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8.0),
              Container(
                color: AppTheme
                    .primaryBackgroundColor, // Example color for the banner
                child: Text(
                  'Choose a module',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Flexible(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: elements.length,
                  itemBuilder: (context, index) {
                    final element = elements[index];
                    return _buildElementCard(context, element);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildElementCard(BuildContext context, HealthElement element) {
    return InkWell(
      onTap: () {
        if (element.isActive) {
          _handleButtonClick(element);
        }
      },
      child: Opacity(
        opacity:
            element.isActive ? 1.0 : 0.5, // Adjust opacity based on isActive
        child: Card(
          shadowColor: AppTheme.primaryColor,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  element.imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      element.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 2.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    if (!element
                        .isActive) // Conditional display of "Coming Soon"
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Coming soon',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1.2,
                          ),
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

  void _handleButtonClick(HealthElement element) async {
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    userId = authProvider.currentUser?.uid ?? '';
    setState(() => isLoading = true);

    try {
      await preloadImages(element);
      bool onboardingCompleted = await FirebaseService()
          .checkOnboardingCompleted(userId, element.title);
      if (!mounted) return;

      if (onboardingCompleted) {
        navigateToAdviceScreen(element);
      } else {
        await FirebaseService()
            .recordOnboardingStatus(userId, element.title, true);
        if (!mounted) return;
        navigateToAdviceScreen(element);
      }
    } catch (e) {
      debugPrint('Error handling button click: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> preloadImages(HealthElement element) async {
    for (var item
        in element.assessments + element.protocols + element.learningCenter) {
      await precacheImage(NetworkImage(item.imageUrl), context);
    }
  }

  void navigateToAdviceScreen(HealthElement element) {
    Navigator.pushNamed(context, '/advice', arguments: element);
  }
}
