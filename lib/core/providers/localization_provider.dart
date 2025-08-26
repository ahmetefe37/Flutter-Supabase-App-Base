import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/localization_service.dart';

class LocalizationNotifier extends StateNotifier<Locale> {
  LocalizationNotifier() : super(const Locale('en', 'US')) {
    _init();
  }

  Future<void> _init() async {
    await LocalizationService.instance.init();
    state = LocalizationService.instance.currentLocale;
  }

  Future<void> changeLanguage(Locale locale) async {
    await LocalizationService.instance.changeLanguage(locale);
    state = locale;
  }

  List<Locale> get supportedLocales => LocalizationService.supportedLocales;

  String getLanguageName(String languageCode) =>
      LocalizationService.instance.getLanguageName(languageCode);

  String getLanguageFlag(String languageCode) =>
      LocalizationService.instance.getLanguageFlag(languageCode);
}

final localizationProvider = StateNotifierProvider<LocalizationNotifier, Locale>(
  (ref) => LocalizationNotifier(),
);
