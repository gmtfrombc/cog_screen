import 'package:cog_screen/themes/app_theme.dart';
import 'package:flutter/material.dart';

class GradientImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double borderRadius;
  final double topPadding;
  final double gradientOpacity;

  const GradientImage({
    super.key,
    required this.imagePath,
    this.width = 200.0,
    this.height = 150.0,
    this.borderRadius = 10.0,
    this.topPadding = 10.0,
    this.gradientOpacity = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
      child: Stack(
        children: [
          Positioned(
            top: topPadding,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: width, // Set a fixed width for the image
              height: height, // Set a fixed height for the image
            ),
          ),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primaryColor.withOpacity(
                      gradientOpacity), // Adjust the opacity as needed
                  Colors.transparent, // Gradually fade to transparent
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
