import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle headlineLarge = GoogleFonts.spaceGrotesk(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headlineMedium = GoogleFonts.spaceGrotesk(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headlineSmall= GoogleFonts.spaceGrotesk(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );

  static TextStyle titleLarge = GoogleFonts.spaceGrotesk(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleMedium = GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleSmall= GoogleFonts.spaceGrotesk(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

  static TextStyle bodyLarge(BuildContext context) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  static TextStyle bodyMedium = GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodySmall= GoogleFonts.spaceGrotesk(
      fontSize: 12,
      fontWeight: FontWeight.normal,
    );

  static TextStyle labelLarge(BuildContext context) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  static TextStyle labelMedium = GoogleFonts.spaceGrotesk(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );

  static TextStyle labelSmall(BuildContext context) {
    return GoogleFonts.spaceGrotesk(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  static TextStyle disabledText = GoogleFonts.spaceGrotesk(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );
}
