import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videocallsample/core/theme/text_styles.dart';

class AppThemes {
  static final appbarTheme2 =  AppBarTheme(
  centerTitle: true,
  foregroundColor: Colors.white,
  backgroundColor: AppThemes.primaryColor,
  iconTheme: const IconThemeData(color: Colors.white),
  titleTextStyle: AppTextStyles.headlineMedium.copyWith(color: Colors.white),
  actionsIconTheme: IconThemeData(color: accentColor),
  );
  static final Color primaryColor = Color(0xFF032252);
  static final Color accentColor = Colors.red;
  static final Color secondaryColor = Colors.grey.shade50;
  static final LinearGradient appLinearGradient = LinearGradient(
    colors: [
      Color(0xFF037137),
      Color(0xFF05B658),
    ],
    stops: [0.17, 0.66,],
    begin: Alignment.centerLeft,
    end: Alignment
        .centerRight,
  );
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    hintColor: accentColor,
    scaffoldBackgroundColor: Colors.white,

    appBarTheme: AppBarTheme(
      centerTitle: true,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: AppTextStyles.headlineMedium.copyWith(color: Colors.black),
      actionsIconTheme: IconThemeData(color: accentColor),
    ),
    textTheme: GoogleFonts.spaceGroteskTextTheme(
      ThemeData.light().textTheme,
    ).apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    primaryTextTheme: GoogleFonts.spaceGroteskTextTheme(
      ThemeData.light().primaryTextTheme,
    ).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.spaceGrotesk(fontSize: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentColor,
        textStyle: GoogleFonts.spaceGrotesk(fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: BorderSide(color: primaryColor),
        textStyle: GoogleFonts.spaceGrotesk(fontSize: 16),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: secondaryColor),
      ),
      hintStyle: GoogleFonts.spaceGrotesk(color: secondaryColor),
    ),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      surface: Colors.white,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: secondaryColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: secondaryColor,
      backgroundColor: Colors.white,
    ),
  );
}
