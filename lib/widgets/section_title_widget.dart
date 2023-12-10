import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final EdgeInsets margin;

  const SectionTitle(
      {super.key,
      required this.title,
      required this.icon,
      required this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.black.withOpacity(0.7),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              title,
              style: GoogleFonts.robotoSlab(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 0.5),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
