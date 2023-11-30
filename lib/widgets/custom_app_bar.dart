import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final double elevation;
  final List<Widget>? actions;
  final bool showLeading;
  final bool showEndDrawerIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.white, // Default color
    this.elevation = 0.0, // Default elevation
    this.actions,
    this.showLeading = true,
    this.showEndDrawerIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      centerTitle: false,
      backgroundColor: backgroundColor,
      elevation: elevation,
      automaticallyImplyLeading: showLeading,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actions: <Widget>[
        if (showEndDrawerIcon)
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.black,
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
      ],
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
