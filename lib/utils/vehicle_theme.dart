import 'package:flutter/material.dart';

class VehicleTheme {
  final String brandName;
  final Color primaryColor;
  final Color accentColor;
  final List<Color> gradientColors;
  final Color textColor;
  final Color subtitleColor;
  final IconData logoIcon;
  final Color shadowColor;

  const VehicleTheme({
    required this.brandName,
    required this.primaryColor,
    required this.accentColor,
    required this.gradientColors,
    required this.textColor,
    required this.subtitleColor,
    required this.logoIcon,
    required this.shadowColor,
  });

  static VehicleTheme getThemeForVehicle(String vehicleName) {
    final nameLower = vehicleName.toLowerCase();
    
    // Shared frosted-glass colors
    final frostedGradients = [
      Colors.white.withValues(alpha: 0.75),
      Colors.white.withValues(alpha: 0.45),
    ];
    const darkTextColor = Color(0xFF0F172A); // Slate 900
    const darkSubtitleColor = Color(0xFF64748B); // Slate 500

    if (nameLower.contains('mercedes') || nameLower.contains('benz')) {
      return VehicleTheme(
        brandName: 'Mercedes-Benz',
        primaryColor: const Color(0xFF475569), // Slate 600
        accentColor: const Color(0xFF64748B), // Slate 500
        gradientColors: frostedGradients,
        textColor: darkTextColor,
        subtitleColor: darkSubtitleColor,
        logoIcon: Icons.star_rounded,
        shadowColor: const Color(0xFF64748B).withValues(alpha: 0.16), // Silver/Grey ambient glow
      );
    } else if (nameLower.contains('bmw') || nameLower.contains('m4')) {
      return VehicleTheme(
        brandName: 'BMW',
        primaryColor: const Color(0xFF1D4ED8), // Blue 700
        accentColor: const Color(0xFF2563EB), // Blue 600
        gradientColors: frostedGradients,
        textColor: darkTextColor,
        subtitleColor: darkSubtitleColor,
        logoIcon: Icons.album_rounded,
        shadowColor: const Color(0xFF2563EB).withValues(alpha: 0.14), // Blue ambient glow
      );
    } else if (nameLower.contains('tesla') || nameLower.contains('ev')) {
      return VehicleTheme(
        brandName: 'Tesla',
        primaryColor: const Color(0xFFDC2626), // Red 600
        accentColor: const Color(0xFFEF4444), // Red 500
        gradientColors: frostedGradients,
        textColor: darkTextColor,
        subtitleColor: darkSubtitleColor,
        logoIcon: Icons.flash_on_rounded,
        shadowColor: const Color(0xFFEF4444).withValues(alpha: 0.14), // Red ambient glow
      );
    }

    // Default premium frosted slate/blue theme
    return VehicleTheme(
      brandName: 'Premium Service',
      primaryColor: const Color(0xFF4B5563), // Grey 600
      accentColor: const Color(0xFF3B82F6), // Blue 500
      gradientColors: frostedGradients,
      textColor: darkTextColor,
      subtitleColor: darkSubtitleColor,
      logoIcon: Icons.directions_car_filled_rounded,
      shadowColor: const Color(0xFF3B82F6).withValues(alpha: 0.10), // Subtle blue-slate ambient shadow
    );
  }
}
