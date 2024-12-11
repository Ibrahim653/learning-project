import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'error_pageNotFound',
          style: Theme.of(context).textTheme.headlineSmall,
        ).tr(),
      ),
    );
  }
}
