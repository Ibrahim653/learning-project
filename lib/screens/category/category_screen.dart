import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';

import '../../providers/category_notifier.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryState = ref.watch(CategoryNotifier.provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: categoryState.when(
        onData: (categories) {
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index]),
              );
            },
          );
        },
        onLoading: () => const Center(child: CircularProgressIndicator()),
        onError: (error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Failed to load categories: ${error.message}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(CategoryNotifier.provider.notifier)
                        .fetchCategories();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        onOther: (state) => const Center(child: Text('Unexpected state')),
      ),
    );
  }
}
