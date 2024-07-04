import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/generated/codegen_loader.g.dart';
import 'package:riverpod_files/generated/locale_keys.g.dart';
import 'package:riverpod_files/helper/locale.dart';
import 'package:riverpod_files/screens/cart/cart_screen.dart';
import 'package:riverpod_files/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(ProviderScope(
      child: EasyLocalization(
    supportedLocales: const [AppLocale.arabic, AppLocale.english],
    path: 'assets/translations',
    assetLoader: const CodegenLoader(),
    fallbackLocale: AppLocale.english,
    useOnlyLangCode: true,
    child: const MyApp(),
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) {
        return LocaleKeys.home_screen_title.tr();
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const HomeScreen(),
    );
  }
}
