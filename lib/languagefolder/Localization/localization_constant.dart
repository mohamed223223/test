import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_app/languagefolder/Localization/demo_localization.dart';

String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).getTranslatedValue(key);
}

// Language Code
const String ARABIC = "ar";
const String ENGLISH = "en";

const String LANGUAGE_CODE = "language_code";

Future<Locale> setLocal(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString(LANGUAGE_CODE, languageCode);

  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case ENGLISH:
      _temp = Locale(languageCode, "US");
      break;
    case ARABIC:
      _temp = Locale(languageCode, "SA");
      break;
    default:
      _temp = const Locale(ENGLISH, "US");
  }

  return _temp;
}

Future<Locale> getLocal() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? ENGLISH;
  // ?? Thats is meain if its null use "en"

  return _locale(languageCode);
}
