import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import '../../providers/search_notifier.dart';
import '../../providers/products_provider/product_details_notifier.dart';
import '../../routes/custome_router.dart';

class ProductSearchScreen extends ConsumerStatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  ConsumerState<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends ConsumerState<ProductSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    EasyDebounce.debounce(
      'search-debounce',
      const Duration(milliseconds: 300),
      () {
        final query = _searchController.text;
        if (query.isNotEmpty) {
          ref.read(SearchNotifier.provider.notifier).searchProducts(query);
        } else {
          ref.read(SearchNotifier.provider.notifier).clearResults();
        }
      },
    );
  }

  void _onClearSearch() {
    _searchController.clear();
    ref.read(SearchNotifier.provider.notifier).clearResults();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(SearchNotifier.provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for products...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _onClearSearch,
                ),
              ),
            ),
          ),
        ),
      ),
      body: searchState.when(
        onData: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('Search for products...'));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.network(product.thumbnail, width: 60, height: 60, fit: BoxFit.cover),
                  title: Text(product.title),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  onTap: () {
                    ref.read(ProductDetailsNotifier.provider.notifier).fetchProductDetails(product.id);
                    context.push(AppRoute.productDetails.path);
                  },
                ),
              );
            },
          );
        },
        onLoading: () => const Center(child: CircularProgressIndicator()),
        onError: (error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load search results: ${error.message}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final query = _searchController.text;
                  if (query.isNotEmpty) {
                    ref.read(SearchNotifier.provider.notifier).searchProducts(query);
                  }
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        onOther: (state) => const Center(child: Text('Search for products...')),
      ),
    );
  }
}
