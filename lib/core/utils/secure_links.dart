import 'dart:convert';

class SecureLinks {
  SecureLinks._();

  static String _decode(String encoded) {
    return utf8.decode(base64.decode(encoded));
  }
  // ───────── PROFILE AVATAR ─────────

  static const String _avatar =
      "aHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL3VjP2V4cG9ydD12aWV3JmlkPTE0VzNqSlpXOHJxakUtWU14bGgyTFpHRl85VVlZNHJTTg==";

  static String get avatar => _decode(_avatar);

  // ───────── CV ─────────

  static const String _cv =
      "aHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUvZC8xamZCRWJMNzk3QmIya0xMQVdiZmFRdjVaV3pfS2R6c3Evdmlldz91c3A9ZHJpdmVfbGluaw==";

  static String get cv => _decode(_cv);

  // ───────────────── Social ─────────────────

  static const String _github = "aHR0cHM6Ly9naXRodWIuY29tL2FiaGlqaXRocDY1";

  static const String _linkedin =
      "aHR0cHM6Ly93d3cubGlua2VkaW4uY29tL2luL2FiaGlqaXRoLXAtMjI3M2I2MTEzLw==";

  static const String _email = "bWFpbHRvOmFiaGlqaXRocGluZm9AZ21haWwuY29t";

  static const String _stackoverflow =
      "aHR0cHM6Ly9zdGFja292ZXJmbG93LmNvbS91c2Vycy8yNzkzNjA4My9hYmhp";

  static String get github => _decode(_github);
  static String get linkedin => _decode(_linkedin);
  static String get email => _decode(_email);
  static String get stackoverflow => _decode(_stackoverflow);
}
