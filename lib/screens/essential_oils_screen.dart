import 'package:cog_screen/models/research_model.dart';
import 'package:cog_screen/providers/app_navigation_state.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/bottom_bar_navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // Import constants

class EssentialOilScreen extends StatefulWidget {
  const EssentialOilScreen({super.key});

  @override
  State<EssentialOilScreen> createState() => _EssentialOilScreenState();
}

class _EssentialOilScreenState extends State<EssentialOilScreen> {
  final double horizontalMargin = 8.0;
  final double verticalMargin = 4.0;
  final EdgeInsets cardPadding = const EdgeInsets.all(8.0);
  final Color cardShadowColor = AppTheme.secondaryColor.withOpacity(0.7);
  final String articlePath =
      'https://powermeacademy.com/lessons/how-essential-oils-benefit-memory-and-cognitive-health/';
  bool isLoading = false;
  String userId = '';
  @override
  Widget build(BuildContext context) {
    final appNavigationProvider = Provider.of<AppNavigationProvider>(context);
    final authProvider = Provider.of<AuthProviderClass>(context, listen: false);
    userId = authProvider.currentUser?.uid ?? '';

    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      showDrawer: false,
      showAppBar: false,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: appNavigationProvider.currentIndex,
        context: context,
        appNavigationProvider: appNavigationProvider,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildHeader(context),
                _buildTextURL(context),
                _buildResearchHeader(context),
                _buildResearchGrid(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ClipPath(
            clipper: ConvexBottomClipper(),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor.withOpacity(0.5),
                BlendMode.colorBurn,
              ),
              child: Image.asset(
                'lib/assets/images/dT_EO9.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 120,
          //bottom: 100,
          left: 10,
          child: Text(
            'Essential Oils and Brain\nHealth',
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0.5,
                fontFamily: GoogleFonts.robotoSlab().fontFamily,
                height: 1.2),
          ),
        ),
        Positioned(
          top: 60,
          child: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 40,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextURL(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Text(
            'Recent Articles',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.robotoSlab().fontFamily,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '- Our latest article: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                      'How Essential Oils Benefit \n   Memory and Cognitive Health',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: TextButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await Navigator.pushNamed(context, '/viewScreen',
                  arguments: articlePath);
              setState(
                () {
                  isLoading = false;
                },
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: AppTheme.tertiaryColor,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              minimumSize: const Size(50, 30),
            ),
            child: const Text(
              'Read the full article',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResearchHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Text(
            'Latest Essential Oil Research',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.robotoSlab().fontFamily,
              color: Colors.black,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
          child: Text(
              '- Recent research on essential oils and cognitive \n   health, memory, and more.'),
        ),
      ],
    );
  }

  Widget _buildResearchGrid(BuildContext context) {
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
      itemCount: elements.length,
      itemBuilder: (context, index) {
        final element = elements[index];
        return _buildSupportCard(context, element.title, element.description,
            element.link, element.image, element.url);
      },
    );
  }

  Widget _buildSupportCard(BuildContext context, String title,
      String description, String route, String imagePath, String url) {
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
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            await Navigator.pushNamed(context, '/viewScreen', arguments: url);
            setState(
              () {
                isLoading = false;
              },
            );
          },
          child: SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    child: SizedBox(
                      width:
                          double.infinity, // Takes the full width of the card
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
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 6.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14, // Increased font size
                      color: Colors.black, // Consistent text color
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12, // Increased font size
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
