import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalization {
  final Locale locale;

  Map<String, String>? _localizedValues;

  DemoLocalization(this.locale);

  static DemoLocalization of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization)!;
  }

  Future load() async {
    String jsonStringValues = await rootBundle
        .loadString("lib/languagefolder/lang/${locale.languageCode}.json");

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  getTranslatedValue(String key) {
    return _localizedValues![key];
  }

  static const LocalizationsDelegate<DemoLocalization> delegate =
      _DemoLocalizationDelegate();
}

class _DemoLocalizationDelegate
    extends LocalizationsDelegate<DemoLocalization> {
  const _DemoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_DemoLocalizationDelegate old) => false;
}
