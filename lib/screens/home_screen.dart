import 'package:cog_screen/models/health_element.dart';
import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondaryColor,
                    fontFamily: GoogleFonts.robotoSlab().fontFamily,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: GridView.builder(
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
        Navigator.pushNamed(context, element.route);
      },
      child: Card(
        clipBehavior: Clip
            .antiAlias, // Ensure the image is clipped to the card's border radius
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Set card border radius
        ),
        child: Stack(
          alignment: Alignment.center, // Center alignment for the text
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(element.imagePath),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), // Black overlay with opacity
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            Text(
              element.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 26,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    offset: const Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
