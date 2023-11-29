import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final AuthProvider authProvider;
  final bool showAppBar;
  final AppBar? customAppBar;

  const BaseScreen({
    super.key,
    required this.child,
    required this.authProvider,
    this.showAppBar = true,
    this.customAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? (customAppBar ??
              AppBar(
                  // Default AppBar configuration
                  ))
          : null,
      drawer: const CustomDrawer(
          // Other drawer configurations
          ),
      body: child,
    );
  }
}
