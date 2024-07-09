import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/products_provider/product_details_notifier.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetailsState = ref.watch(ProductDetailsNotifier.provider);

    return productDetailsState.when(
      data: (product) {
        if (product == null) {
          return const Center(child: Text('No product found'));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(product.thumbnail),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title,
                          style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(height: 10),
                      Text('\$${product.price.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 10),
                      Text(product.description),
                      const SizedBox(height: 20),
                      Text('Category: ${product.category}'),
                      Text('Rating: ${product.rating.toString()}'),
                      const SizedBox(height: 20),
                      const Text('Images:'),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: product.images.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(product.images[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
