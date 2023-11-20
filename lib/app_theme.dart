import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //Primary and Secondary Colors
  static const Color _primaryColor = Color(0xFF405f53); // Deep green
  static const Color _secondaryColor = Color(0xFF555b89); // Muted blue
  static const Color _primaryBackgroundColor =
      Color(0xFFfaf4ed); // Off white background

//Additional Colors from Styling Guide
  static const Color _primaryVariant1 = Color(0xFFB9DDD4);
  static const Color _primaryVariant2 = Color(0xFFF2644E); // Shade 1
  static const Color _colorFBDACB = Color(0xFFFBDACB); // Shade 2
// Shade 3
  static const Color _color7D5E7A = Color(0xFF7D5E7A); // Shade 4
  static const Color _color7E9E93 = Color(0xFF7E9E93); // Shade 5
  static const Color _color9E9D8F = Color(0xFF9E9D8F); // Shade 6
  static const Color _colorF79F8C = Color(0xFFF79F8C); // Shade 7
  static const Color _colorA5616C = Color(0xFFA5616C); // Shade 8

//Getters for colors
  static Color get primaryColor => _primaryColor;
  static Color get secondaryColor => _secondaryColor;
  static Color get primaryBackgroundColor => _primaryBackgroundColor;
  static Color get primaryVariant1 => _primaryVariant1;
  static Color get primaryVariant2 => _primaryVariant2;
  static Color get colorFBDACB => _colorFBDACB;

  static Color get color7D5E7A => _color7D5E7A;
  static Color get color7E9E93 => _color7E9E93;
  static Color get color9E9D8F => _color9E9D8F;
  static Color get colorF79F8C => _colorF79F8C;
  static Color get colorA5616C => _colorA5616C;

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: GoogleFonts.outfit().fontFamily,
      // The colorScheme property handles app-wide color theming
      colorScheme: const ColorScheme(
        primary: _primaryColor,
        primaryContainer: _primaryVariant1,
        secondary: _secondaryColor,
        secondaryContainer: _primaryVariant2,
        surface: _color7D5E7A,
        background: _primaryBackgroundColor,
        error: _colorF79F8C,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.black,
        onError: Colors.white,
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
            color: _colorA5616C),
        displayLarge: const TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: const TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.w400, color: _color9E9D8F),
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
          borderSide: const BorderSide(color: _colorFBDACB),
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
