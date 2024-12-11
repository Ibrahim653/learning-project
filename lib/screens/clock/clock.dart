import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/providers/clock_provider.dart';

class ClockScreen extends ConsumerWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clockState = ref.watch(ClockNotifier.provider);

    return Scaffold(
      body: clockState.when(
        onData: (currentTime) {
          final formattedTime = DateFormat.Hms().format(currentTime);
          return Center(
            child: Text(
              formattedTime,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          );
        },
        onLoading: () => const Center(child: CircularProgressIndicator()),
        onError: (error) => Center(child: Text('Error: ${error.message}')),
        onOther: (state) =>  const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
