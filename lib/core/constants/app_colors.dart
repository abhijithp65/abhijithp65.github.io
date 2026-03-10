part of 'values.dart';

class AppColors {
  // Primary - Green
  static const Color primaryColor = Color.fromRGBO(21, 181, 114, 1);
  static const Color primary200 = Color.fromRGBO(17, 155, 97, 1);
  static const Color primary300 = Color.fromRGBO(14, 130, 81, 1);

  // Background - Dark Navy
  static const Color backgroundColor = Color.fromRGBO(7, 17, 26, 1);
  static const Color secondaryColor = Color.fromRGBO(12, 27, 40, 1);

  // Danger
  static const Color dangerColor = Color.fromRGBO(249, 77, 30, 1);

  // Caption / muted text
  static const Color captionColor = Color.fromRGBO(166, 177, 187, 1);

  // Surface cards (dark panels)
  static const Color cardColor = Color.fromRGBO(13, 28, 42, 1);
  static const Color cardBorder = Color.fromRGBO(25, 50, 70, 1);

  // Accent tint of primary (for chip backgrounds etc.)
  static const Color primaryTint = Color.fromRGBO(21, 181, 114, 0.12);

  // Text
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF3F3F3);
  static const Color black = Color(0xFF000000);
  static const Color black400 = Color(0xFF212121);

  // Greys (kept for compatibility)
  static const Color grey50 = Color(0xFFF2F1F1);
  static const Color grey70 = Color(0xFFEDECEC);
  static const Color grey100 = Color.fromRGBO(25, 50, 70, 1);
  static const Color grey150 = Color.fromRGBO(50, 80, 105, 1);
  static const Color grey250 = Color.fromRGBO(90, 115, 135, 1);

  // Legacy aliases so existing code doesn't break
  static const Color accentColor = Color.fromRGBO(10, 22, 34, 1);
  static const Color accentColor100 = Color.fromRGBO(12, 27, 40, 1);
  static const Color primaryText1 = Color.fromRGBO(166, 177, 187, 1);
  static const Color primaryText2 = Color.fromRGBO(140, 155, 168, 1);
  static const Color yellow10 = Color.fromRGBO(21, 181, 114, 0.10);
  static const Color yellow700 = Color.fromRGBO(14, 130, 81, 1);
  static const Color blue300 = Color.fromRGBO(21, 181, 114, 1);
  static const Color pink300 = Color.fromRGBO(249, 77, 30, 1);
  static const Color red = Color.fromRGBO(249, 77, 30, 1);
  static const Color darkWhite = Color(0xFFDFDFDF);
  static const Color offWhite200 = Color(0xFFE5E5DB);
  static const Color black100 = Color.fromRGBO(13, 28, 42, 1);
  static const Color black200 = Color.fromRGBO(18, 36, 52, 1);
}
