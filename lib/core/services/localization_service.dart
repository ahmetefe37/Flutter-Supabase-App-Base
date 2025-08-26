import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService {
  LocalizationService._();
  static LocalizationService? _instance;
  static LocalizationService get instance => _instance ??= LocalizationService._();

  static const String _languageKey = 'selected_language';
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('tr', 'TR'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
    Locale('de', 'DE'),
  ];

  late SharedPreferences _prefs;
  Locale? _currentLocale;

  /// Initialize the service
  static Future<void> initialize() async {
    await instance.init();
  }

  /// Initialize the service
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await loadSavedLanguage();
  }

  /// Get current locale
  Locale get currentLocale => _currentLocale ?? _getDeviceLocale();

  /// Get device locale
  Locale _getDeviceLocale() {
    final deviceLocale = PlatformDispatcher.instance.locale;

    // Check if device locale is supported
    for (final locale in supportedLocales) {
      if (locale.languageCode == deviceLocale.languageCode) {
        return locale;
      }
    }

    // Return default locale if device locale is not supported
    return const Locale('en', 'US');
  }

  /// Load saved language
  Future<void> loadSavedLanguage() async {
    final languageCode = _prefs.getString(_languageKey);
    if (languageCode != null) {
      _currentLocale = supportedLocales.firstWhere(
        (locale) => locale.languageCode == languageCode,
        orElse: _getDeviceLocale,
      );
    } else {
      _currentLocale = _getDeviceLocale();
    }
  }

  /// Change language
  Future<void> changeLanguage(Locale locale) async {
    if (supportedLocales.contains(locale)) {
      _currentLocale = locale;
      await _prefs.setString(_languageKey, locale.languageCode);
    }
  }

  /// Get language name
  String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'tr':
        return 'Türkçe';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      default:
        return 'English';
    }
  }

  /// Get flag emoji for language
  String getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇺🇸';
      case 'tr':
        return '🇹🇷';
      case 'es':
        return '🇪🇸';
      case 'fr':
        return '🇫🇷';
      case 'de':
        return '🇩🇪';
      default:
        return '🇺🇸';
    }
  }
}
