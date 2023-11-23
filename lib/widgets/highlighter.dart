import 'package:flutter/material.dart';

class HighlightedTitle extends StatelessWidget {
  final String text;
  final Color highlightColor;

  const HighlightedTitle({
    super.key,
    required this.text,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: highlightColor
          .withOpacity(0.3), // Adjust opacity for highlight effect
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
