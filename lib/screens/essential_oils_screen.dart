import 'package:cog_screen/models/essential_oils_model.dart';
import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/health_element_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/services/firebase_services.dart';
//import 'package:cog_screen/screens/web_view.dart';
//import 'package:cog_screen/screens/view_screen.dart';
//import 'package:cog_screen/screens/web_view.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'platform_specific_webview.dart';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // Import constants

class EssentialOilScreen extends StatefulWidget {
  const EssentialOilScreen({super.key});

  @override
  State<EssentialOilScreen> createState() => _EssentialOilScreenState();
}

class _EssentialOilScreenState extends State<EssentialOilScreen> {
  String articlePath = '';
  bool isLoading = false;
  static Color cardShadowColor = AppTheme.secondaryColor.withOpacity(0.7);

  @override
  Widget build(BuildContext context) {
    return Consumer3<HealthElementProvider, AppNavigationProvider,
        AuthProviderClass>(
      builder: (context, healthElementProvider, appNavigationProvider,
          authProvider, _) {
        final healthElement = healthElementProvider.currentHealthElement;
        articlePath = healthElement!.title == 'Sleep'
            ? 'https://powermeacademy.com/topic/the-soothing-power-of-essential-oils-and-blends-for-sleep'
            : 'https://powermeacademy.com/lessons/how-essential-oils-benefit-memory-and-cognitive-health/';

        return BaseScreen(
          authProvider: authProvider,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildHeader(context, healthElement),
                _buildMiddleCard(context, healthElement),
                _buildResearchHeader(context),
                _buildResearchGrid(context, healthElement)

                // Your widgets here...
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, HealthElement? healthElement) {
    EssentialOilsModel essentialOilsModel = healthElement!.essentialOils;
    final header = essentialOilsModel.header;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: ClipPath(
            clipper: ConvexBottomClipper(),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                AppTheme.primaryColor.withOpacity(0.9),
                BlendMode.colorBurn,
              ),
              child: Image.asset(
                header.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 30,
          //bottom: 100,
          left: 20,
          child: Text(
            header.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 0.5,
              fontFamily: GoogleFonts.robotoSlab().fontFamily,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMiddleCard(BuildContext context, HealthElement? healthElement) {
    final EssentialOilsModel essentialOilsModel = healthElement!.essentialOils;
    final EOScreenArticles articles = essentialOilsModel.articles;
    String userAction = '';
    return Container(
      width: double.infinity,
      height: 220, // Spans the entire width of the screen
      color: articles.color, // Background color
      padding: const EdgeInsets.all(10), // Padding around the content
      child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  articles.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.robotoSlab().fontFamily,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8), // Spacing between widgets
                SizedBox(
                  width: 240,
                  child: Text(
                    articles.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 12), // Spacing between widgets
                TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    userAction = 'recent article';
                    _handleButtonClick(healthElement, userAction);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebView(url: articlePath),
                      ),
                    );
                    setState(
                      () {
                        isLoading = false;
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    minimumSize: const Size(60, 40),
                  ),
                  child: const Text(
                    'Read the full article',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10, // Distance from right
            bottom: 10, // Distance from bottom
            child: Image.asset(
              articles.image, // Replace with your image asset path
              width: 120, // Adjust the width as needed
              height: 120, // Adjust the height as needed
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    userAction = 'recent article';
                    _handleButtonClick(healthElement, userAction);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebView(url: articlePath),
                      ),
                    );
                    setState(
                      () {
                        isLoading = false;
                      },
                    );
                  },
                  child: const Icon(
                    Icons.arrow_forward_sharp,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResearchHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 2.0,
          ),
          child: Text(
            'Science and Research',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.robotoSlab().fontFamily,
              color: Colors.black,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
        ),
      ],
    );
  }

  Widget _buildResearchGrid(
      BuildContext context, HealthElement? healthElement) {
    final EssentialOilsModel essentialOilsModel = healthElement!.essentialOils;
    final List<EOResearch> researchList = essentialOilsModel.research;
    return GridView.builder(
      shrinkWrap: true, // This will make GridView take the minimum space
      physics:
          const NeverScrollableScrollPhysics(), // Disables scrolling within the GridView
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 4,
        childAspectRatio: 0.8,
      ),
      itemCount: researchList.length,
      itemBuilder: (context, index) {
        final EOResearch researchArticle = researchList[index];
        return _buildSupportCard(context, researchArticle);
      },
    );
  }

  Widget _buildSupportCard(
    BuildContext context,
    EOResearch researchArticle,
  ) {
    String userAction = '';
    final HealthElement healthElement =
        Provider.of<HealthElementProvider>(context, listen: false)
            .currentHealthElement!;
    return InkWell(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        userAction = 'research article';
        _handleButtonClick(healthElement, userAction);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebView(
              url: researchArticle.url,
            ),
          ),
        );
        setState(
          () {
            isLoading = false;
          },
        );
      },
      child: Container(
        width: 180,
        height: 250,
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
          child: SizedBox(
            width: 160,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    researchArticle.image,
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    width: 82,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white, // Border color
                        width: 1.0, // Border thickness
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
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              researchArticle.description,
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
                  bottom: 30,
                  left: 20,
                  child: SizedBox(
                    height: 100,
                    width: 140,
                    child: Text(
                      researchArticle.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.9,
                      ),
                      maxLines: 4,
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
      ),
    );
  }

  void _handleButtonClick(HealthElement element, String userAction) async {
    final userId =
        Provider.of<AuthProviderClass>(context, listen: false).currentUser!.uid;
    try {
      await FirebaseService().recordUserAction(
        userId,
        '${element.title} $userAction',
        userAction,
      ); // Removed the navigation call from here
    } catch (e) {
      debugPrint('Error recording user action: $e');
    }
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
