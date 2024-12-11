import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/screens/products/products_search_screen.dart';
import '../../providers/products_provider/products_notifier.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      ref.read(ProductsNotifier.provider.notifier).nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(ProductsNotifier.provider);
    final productNotifier = ref.watch(ProductsNotifier.provider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductSearchScreen()),
              );
            },
          ),
        ],
      ),
      body: productState.when(
        onData: (products) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: products.length + 1,
            itemBuilder: (context, index) {
              if (index < products.length) {
                final product = products[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
              } else if (products.length < productNotifier.totalProducts) {
                return SpinKitThreeBounce(
                  color: Colors.purple,
                  size: 25,
                );
              } else {
                return SizedBox.shrink();
              }
            },
          );
        },
        onLoading: () => Center(child: CircularProgressIndicator()),
        onError: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
