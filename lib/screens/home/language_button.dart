import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_files/helper/locale.dart';

import '../../generated/locale_keys.g.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      onPressed: () {
        final currentLocale = context.locale;
        final newLocale = currentLocale == AppLocale.arabic ? AppLocale.english : AppLocale.arabic;
        context.setLocale(newLocale);
      },
      child: Text(
        LocaleKeys.change.tr(),
        style: const TextStyle(
          color: Colors.black45,
        ),
      ),
    );
  }
}
