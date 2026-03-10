import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_portfolio/core/constants/values.dart';

class AppTheme {
  static const _bold    = FontWeight.w700;
  static const _regular = FontWeight.w400;

  static ThemeData lightThemeData = ThemeData(
    colorScheme: const ColorScheme(
      primary:    AppColors.primaryColor,
      secondary:  AppColors.primaryColor,
      surface:    AppColors.cardColor,
      error:      AppColors.dangerColor,
      onPrimary:  AppColors.white,
      onSecondary:AppColors.white,
      onSurface:  AppColors.white,
      onError:    AppColors.white,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    highlightColor: Colors.transparent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: const IconThemeData(color: AppColors.white),
    dividerColor: AppColors.cardBorder,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.ibmPlexMono(
        fontSize: Sizes.TEXT_SIZE_60, color: AppColors.white, fontWeight: _bold),
      displayMedium: GoogleFonts.ibmPlexMono(
        fontSize: Sizes.TEXT_SIZE_48, color: AppColors.white, fontWeight: _bold),
      displaySmall: GoogleFonts.ibmPlexMono(
        fontSize: Sizes.TEXT_SIZE_34, color: AppColors.white, fontWeight: _bold),
      headlineMedium: GoogleFonts.ibmPlexMono(
        fontSize: Sizes.TEXT_SIZE_24, color: AppColors.primaryColor, fontWeight: _bold),
      headlineSmall: GoogleFonts.ibmPlexMono(
        fontSize: Sizes.TEXT_SIZE_20, color: AppColors.white, fontWeight: _bold),
      titleLarge: GoogleFonts.ibmPlexMono(
        fontSize: Sizes.TEXT_SIZE_18, color: AppColors.white, fontWeight: _bold),
      titleSmall: GoogleFonts.ibmPlexMono(
        fontSize: Sizes.TEXT_SIZE_14, color: AppColors.white, fontWeight: _bold),
      bodyLarge: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_16, color: AppColors.captionColor, fontWeight: _regular),
      bodySmall: GoogleFonts.ibmPlexMono(
        fontSize: Sizes.TEXT_SIZE_12, color: AppColors.captionColor, fontWeight: _regular),
      labelLarge: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_16, color: AppColors.white, fontWeight: _bold),
    ),
  );
}
