import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final AuthProvider authProvider;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? (customAppBar ?? AppBar()) : null,
      endDrawer: showDrawer ? const CustomDrawer() : null,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
