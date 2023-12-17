import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/screens/base_screen.dart';
import 'package:cog_screen/screens/logins/signin_screen.dart';
import 'package:cog_screen/screens/logins/signup_screen.dart';
import 'package:cog_screen/themes/app_theme.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_text_for_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Assuming you have separate files for SignIn and _SignUp widgets

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      authProvider: Provider.of<AuthProviderClass>(context, listen: false),
      showAppBar: false,
      customAppBar: CustomAppBar(
        backgroundColor: AppTheme.primaryBackgroundColor,
        title: const CustomTextForTitle(),
        showEndDrawerIcon: false,
        showLeading: false,
      ),
      showDrawer: false,
      bottomNavigationBar: null, // Your bottom navigation bar, if any
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.primaryBackgroundColor,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Sign In'),
                Tab(text: 'Sign Up'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              SignIn(), // Your SignIn widget
              SignUp(), // Your _SignUp widget
            ],
          ),
        ),
      ),
    );
  }
}
