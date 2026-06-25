import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary Luxury Palette
  static const Color deepBlack = Color(0xFF0A0A0A);
  static const Color charcoal = Color(0xFF121212);
  static const Color champagneGold = Color(0xFFD4AF37);
  static const Color silver = Color(0xFFC0C0C0);
  
  // Accents and UI Elements
  static const Color goldGradientStart = Color(0xFFD4AF37);
  static const Color goldGradientEnd = Color(0xFFB8860B);
  static const Color glassBorder = Color(0x33FFFFFF);
  static const Color glassBackground = Color(0x1AFFFFFF);
  
  static const Color error = Color(0xFFCF6679);
  static const Color textHighEmphasis = Color(0xFFE0E0E0);
  static const Color textMediumEmphasis = Color(0xFFA0A0A0);
}

class AppTheme {
  static ThemeData get luxuryTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.champagneGold,
      scaffoldBackgroundColor: AppColors.deepBlack,
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme.copyWith(
          displayLarge: GoogleFonts.montserrat(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.champagneGold,
            letterSpacing: 1.2,
          ),
          titleLarge: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.silver,
          ),
          bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.textHighEmphasis,
          ),
          bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textMediumEmphasis,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.charcoal.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.champagneGold, width: 2),
        ),
        hintStyle: GoogleFonts.inter(color: AppColors.textMediumEmphasis),
        labelStyle: GoogleFonts.inter(color: AppColors.textHighEmphasis),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.champagneGold;
          }
          return Colors.transparent;
        }),
        side: const BorderSide(color: AppColors.silver),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
