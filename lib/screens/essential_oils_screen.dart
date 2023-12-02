import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:cog_screen/utilities/constants.dart';
import 'package:provider/provider.dart'; // Import constants

class EssentialOilScreen extends StatefulWidget {
  const EssentialOilScreen({super.key});

  @override
  State<EssentialOilScreen> createState() => _EssentialOilScreenState();
}

class _EssentialOilScreenState extends State<EssentialOilScreen> {
  bool isLoading = false;
  String userId = '';
  @override
  Widget build(BuildContext context) {
    final appNavigationProvider = Provider.of<AppNavigationProvider>(context);
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    userId = authProvider.currentUser?.uid ?? ''; // Set userId here

    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      customAppBar: CustomAppBar(
        title: 'Essential Oils',
        backgroundColor: AppTheme.primaryBackgroundColor,
        showEndDrawerIcon: false,
        showLeading: false,
      ),
      showDrawer: false,
      showAppBar: false,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        context: context,
        appNavigationProvider: appNavigationProvider,
      ),
      child: isLoading
          ? const Center(
              child: CustomProgressIndicator(),
            )
          : _buildContent(context), // Extracted content builder
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        const SizedBox(height: 10),
        _buildMemoryEnhancementCard(context),
        const SizedBox(height: 20),
        _buildResearchSection(context),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: ConvexBottomClipper(),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
              BlendMode.colorBurn,
            ),
            child: Image.asset(
              'lib/assets/images/dT_EO9.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Positioned(
          bottom: 90,
          left: 30,
          child: Text(
            'Essential Oils \nand Cognitive Health',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.1),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top,
          left: 10,
          child: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.black45,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  void _handleButtonClick() async {
    debugPrint('Button clicked');
    setState(() {
      isLoading = true;
    });
    try {
      debugPrint('userId: $userId');
      await FirebaseService().recordUserAction(userId, 'InterestedButton');
      if (mounted) {
        debugPrint('Navigating to criteria screen');
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

  Widget _buildMemoryEnhancementCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: AppTheme.primaryBackgroundColor,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/criteria'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.memory,
                    color: AppTheme.primaryColor.withOpacity(0.8),
                    size: 30.0,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Memory Enhancement Protocol',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
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
              Align(
                alignment: Alignment.bottomRight, // Align to bottom-right
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Take minimum space
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.secondaryColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                        // Add other style properties if needed
                      ),
                      onPressed: () {
                        _handleButtonClick();
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "I'm interested",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ), // Your memory enhancement card content here
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String description,
      String route, String imagePath) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Container(
          color: AppTheme.primaryBackgroundColor,
          child: SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90,
                  width: 160,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12, // Increased font size
                      color: Colors.black, // Consistent text color
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 10, // Increased font size
                      fontWeight: FontWeight.w100,
                      color: Colors.black, // Consistent text color
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResearchSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            'Essential Oil Research',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200, // Set a height for the horizontal list
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCard(
                context,
                'Overnight olfactory enrichment using an odorant diffuser improves memory and modifies the uncinate fasciculus in older adults',
                AppConstants.overnightOlfactory,
                '/research',
                'lib/assets/images/research1.jpeg',
              ),
              _buildCard(
                context,
                'Lavender aromatherapy: A systematic review from essential oil quality and administration methods to cognitive enhancing effects',
                AppConstants.lavenderAromatherapy,
                '/research',
                'lib/assets/images/research2.jpeg',
              ),
              _buildCard(
                context,
                "Essential Oils as A Potential Neuroprotective Remedy for Alzheimer's Disease",
                AppConstants.alheimersDisease,
                '/research',
                'lib/assets/images/research4.jpeg',
              ),
              _buildCard(
                context,
                'The effect of the essential oils of lavender and rosemary on the human short-term memory',
                AppConstants.shortTermMemory,
                '/research',
                'lib/assets/images/research3.jpeg',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ConvexBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height);
    var secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(ConvexBottomClipper oldClipper) => false;
}
