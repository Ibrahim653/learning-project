import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/generated/codegen_loader.g.dart';
import 'package:riverpod_files/generated/locale_keys.g.dart';
import 'package:riverpod_files/helper/locale.dart';
import 'package:riverpod_files/networking/api_constants.dart';
import 'package:riverpod_files/routes/custome_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(ProviderScope(
      overrides: [
        EndPoints.
        provider.overrideWith((type) {
          return const EndPoints.forApi(ApiConstants.apiBaseUrl);
        }),
        ITokenHolder.provider.overrideWithValue(_TokenHolder()),
      ],
      child: EasyLocalization(
        supportedLocales: AppLocale.locales,
        path: 'assets/translations',
        assetLoader: const CodegenLoader(),
        fallbackLocale: AppLocale.english,
        useOnlyLangCode: true,
        child: const MyApp(),
      )));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(CustomRouter.provider).goRouter;

    return MaterialApp.router(
      onGenerateTitle: (context) {
        return LocaleKeys.appName.tr();
      },
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
    );
  }
}

class _TokenHolder extends ITokenHolder {
  @override
  String? get accessToken => " set token here ";

  @override
  Future<void> refreshToken() async {}
}
