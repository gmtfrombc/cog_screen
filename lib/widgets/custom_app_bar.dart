import 'package:cog_screen/widgets/shopping_cart_icon.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Color backgroundColor;
  final double elevation;
  final List<Widget>? actions;
  final bool showLeading;
  final bool showEndDrawerIcon;
  final bool showShoppingCartIcon; // New parameter

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.white, // Default color
    this.elevation = 0.0, // Default elevation
    this.actions,
    this.showLeading = true,
    this.showEndDrawerIcon = true,
    this.showShoppingCartIcon = false, // Default value
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> appBarActions = [];
    if (showShoppingCartIcon) {
      appBarActions.add(const ShoppingCartIcon());
    }
    if (showEndDrawerIcon) {
      appBarActions.add(
        IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.black,
          onPressed: () => Scaffold.of(context).openEndDrawer(),
        ),
      );
    }
    return AppBar(
      title: title,
      centerTitle: false,
      backgroundColor: backgroundColor,
      elevation: elevation,
      automaticallyImplyLeading: showLeading,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actions: appBarActions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.shade300,
          height: 1.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight + 5,
      );
}
