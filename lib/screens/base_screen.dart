import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  final AuthProviderClass authProvider;
  final bool showAppBar;
  final CustomAppBar? customAppBar;
  final Widget? bottomNavigationBar;
  final bool showDrawer;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const BaseScreen(
      {super.key,
      required this.child,
      required this.authProvider,
      this.showAppBar = true,
      this.customAppBar,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.showDrawer = true});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  void _signOutUser() async {
    await widget.authProvider.signOut();
    if (mounted) {
      Navigator.of(context)
          .pushReplacementNamed('/'); // Assuming '/login' is your login route
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar ? (widget.customAppBar ?? AppBar()) : null,
      endDrawer: widget.showDrawer
          ? CustomDrawer(
              signOut: _signOutUser, // Pass the sign-out method
            )
          : null,
      body: widget.child,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}
