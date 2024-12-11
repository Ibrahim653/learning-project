// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "appName": "اسم التطبيق",
  "greeting": "مرحباً، قرطبة",
  "home_screen": {
    "title": "الرئيسية",
    "body": "نص الصفحة الرئيسية",
    "toggle_language": "غيّر اللغة"
  },
  "ar": "العربية",
  "en": "English",
  "start": "ابدأ",
  "toggle": "غير اللغة",
  "products": {
    "groovy_shorts": "شورت جروفي",
    "karati_kit": "طقم كاراتي",
    "denim_jeans": "جينز دنيم",
    "red_backpack": "حقيبة ظهر حمراء",
    "drum_sticks": "طبل وعصي",
    "blue_suitcase": "حقيبة زرقاء",
    "roller_skates": "أحذية التزلج",
    "electric_guitar": "جيتار كهربائي"
  }
};
static const Map<String,dynamic> en = {
  "appName": "Application name",
  "greeting": "Hello, Kortobaa!",
  "home_screen": {
    "title": "Home",
    "body": "Home Screen Body Text",
    "toggle_language": "Toggle Language"
  },
  "ar": "العربية",
  "en": "English",
  "start": "Start",
  "toggle": "Toggle Language",
  "products": {
    "groovy_shorts": "Groovy Shorts",
    "karati_kit": "Karati Kit",
    "denim_jeans": "Denim Jeans",
    "red_backpack": "Red Backpack",
    "drum_sticks": "Drum & Sticks",
    "blue_suitcase": "Blue Suitcase",
    "roller_skates": "Roller Skates",
    "electric_guitar": "Electric Guitar"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
