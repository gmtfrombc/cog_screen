import 'package:cog_screen/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import your auth provider

class CustomDrawer extends StatelessWidget {
  final VoidCallback? onSignOut;
  const CustomDrawer({super.key, this.onSignOut});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderClass>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName:
                Text(authProvider.currentUser?.displayName ?? 'User Name'),
            accountEmail:
                Text(authProvider.currentUser?.email ?? 'email@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  authProvider.currentUser?.photoURL ?? 'default_image_url'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sign Out'),
              onTap: onSignOut),
        ],
      ),
    );
  }
}
