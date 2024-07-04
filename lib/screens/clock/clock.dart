import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/clock_provider.dart';

class Clock extends ConsumerWidget {
  const Clock({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTime = ref.watch(clockProvider);
    final formattedTime = DateFormat.Hms().format(currentTime);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(formattedTime,
            style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ],
      ),
    );
  }
}
