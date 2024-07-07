import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riverpod_files/providers/products_provider/products_provider.dart';
import 'package:riverpod_files/screens/products/products_search_screen.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(ProductsNotifier.productsProvider);
    final productsNotifier =
        ref.watch(ProductsNotifier.productsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(ref),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length + 1,
        itemBuilder: (context, index) {
          if (index < products.length) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.thumbnail,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    product.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: Text(
                    product.id.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            );
          } else {
            if (!productsNotifier.isLoading &&
                products.length < productsNotifier.totalProducts) {
              productsNotifier.fetchProducts();
              return const Padding(
                padding: EdgeInsets.all(8),
                child: SpinKitThreeBounce(
                  color: Colors.purple,
                  size: 40,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }
        },
      ),
    );
  }
}
