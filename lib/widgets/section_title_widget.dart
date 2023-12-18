import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 10,
        ),
        child: Text(
          title,
          style: GoogleFonts.robotoSlab(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 0.5,
            shadows: <Shadow>[
              Shadow(
                offset: const Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
          ),
          softWrap: true,
          overflow: TextOverflow.visible,
        ));
  }
}
