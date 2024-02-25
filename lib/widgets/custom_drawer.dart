import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/providers/criteria_provider.dart';
import 'package:cog_screen/providers/survey_provider.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/utilities/brain_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback? signOut;

  const CustomDrawer({super.key, this.signOut});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderClass>(context);
    final surveyProvider = Provider.of<SurveyProvider>(context, listen: false);

    return Drawer(
      child: Container(
        color:
            AppTheme.primaryBackgroundColor, // Set the primary background color
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 60),
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).primaryColor,
              child: authProvider.currentUser?.photoURL != null
                  ? ClipOval(
                      child: Image.network(
                        authProvider.currentUser!.photoURL!,
                        fit: BoxFit.cover,
                        width: 80.0,
                        height: 80.0,
                      ),
                    )
                  : const Icon(
                      Icons.person,
                      size: 40.0,
                      color: Colors.white,
                    ),
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  authProvider.currentUser?.displayName ?? 'User Name',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87),
                ),
                Text(
                  authProvider.currentUser?.email ?? 'email@example.com',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              thickness: 0.5,
              indent: 40,
              endIndent: 40,
              color: Colors.black54,
            ),
            const SizedBox(height: 10),
            _buildDrawerItem(
              Icons.account_circle_outlined,
              'Account',
              () {
                // Navigate to account screen
              },
            ),
            _buildDrawerItem(
              Icons.settings_outlined,
              'Settings',
              () {
                // Navigate to settings screen
              },
            ),
            _buildDrawerItem(
              Icons.exit_to_app,
              'Sign Out',
              () {
                Provider.of<CriteriaProvider>(context, listen: false)
                    .resetCriteria();
                if (signOut != null) {
                  signOut!();
                  surveyProvider.restartSurvey();
                }
              },
            ),
            _buildDrawerItem(
              Icons.description_outlined,
              'Terms of Use',
              () {
                _showTermsOfUseDialog(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback? onTap) {
    return Material(
      color: Colors.transparent, // Maintain the drawer's background color
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  void _showTermsOfUseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms of Use'),
          content: SingleChildScrollView(
            child: Text(
              BrainConstants.loremIpsum,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
                letterSpacing: 0.5,
                fontFamily: GoogleFonts.robotoSlab().fontFamily,
                height: 1.4,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
