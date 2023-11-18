import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF405f53); // Deep green
  static const Color _secondaryColor = Color(0xFF555b89); // Muted blue
  static const Color _primaryBackgroundColor =
      Color(0xFFfaf4ed); // Off white background

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: GoogleFonts.outfit().fontFamily,
      // The colorScheme property handles app-wide color theming
      colorScheme: const ColorScheme(
        primary: _primaryColor,
        onPrimary: Colors.white, // Text/icon color on top of primary
        secondary: _secondaryColor,
        onSecondary: Colors.white, // Text/icon color on top of secondary
        error: Colors.red, // Default color for error, can be customized
        onError: Colors.white, // Text/icon color on top of error
        background: _primaryBackgroundColor,
        onBackground: Colors.black, // Text/icon color on top of background
        surface: Colors.white,
        onSurface: Colors.black, // Text/icon color on top of surface
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: _primaryBackgroundColor,
      appBarTheme: const AppBarTheme(
        color: _primaryColor, // AppBar background color
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.outfit().fontFamily,
        ),
        displayLarge: const TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor, // Button background color
          foregroundColor: Colors.white, // Text and icon color on the button
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Rounded corners for the button
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 12.0), // Button padding
          textStyle: TextStyle(
            fontSize: 16.0, // Font size for button text
            fontFamily: GoogleFonts.outfit().fontFamily, // Font family
            fontWeight: FontWeight.w500, // Font weight
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _secondaryColor, // Text color for TextButton
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor:
              _secondaryColor, // Text and icon color for OutlinedButton
          side: const BorderSide(
              color: _secondaryColor), // Border color for OutlinedButton
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: _secondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: _primaryColor),
        ),
        // Other properties like labelStyle, hintStyle, etc.
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: _secondaryColor,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      cardTheme: CardTheme(
        color: _primaryBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        // Other properties as needed
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _primaryBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        elevation: 10,
        modalBackgroundColor: Colors.white,
        modalElevation: 10,
        // Other properties as needed
      ),

      // Here I'll define other theme properties as needed
    );
  }

  // Add a darkTheme if needed
}
