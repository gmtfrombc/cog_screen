import 'package:cog_screen/providers/auth_provider.dart';
import 'package:cog_screen/widgets/custom_app_bar.dart';
import 'package:cog_screen/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar ? (widget.customAppBar ?? AppBar()) : null,
      endDrawer: widget.showDrawer
          ? CustomDrawer(
              onSignOut: () async {
                await Provider.of<AuthProviderClass>(context, listen: false)
                    .signOut();
                if (mounted) {
                  Navigator.of(context).pushReplacementNamed('/');
                } // Assuming '/login' is your login route
              },
            )
          : null,
      body: widget.child,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}
