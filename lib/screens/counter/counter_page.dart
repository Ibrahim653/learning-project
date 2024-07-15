import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/providers/counter.dart';
import 'package:riverpod_files/routes/custome_router.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(CounterNotifier.provider.notifier);
    final counterState = ref.watch(CounterNotifier.provider);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            counter.increment();
          },
        ),
        body: counterState.when(onData: ((count) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("Value: $count"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoute.category.path);
                },
                child: Text('Go To Category Screen'),
              ),
            ],
          );
        })));
  }
}
