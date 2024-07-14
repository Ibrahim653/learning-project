import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/products_provider/product_details_notifier.dart';
import '../../providers/products_provider/products_notifier.dart';
import '../../routes/custome_router.dart';

class ProductSearchDelegate extends SearchDelegate<String> {
  final WidgetRef ref;

  ProductSearchDelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchResults =
        ref.watch(ProductsNotifier.provider.notifier).searchProducts(query);

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final product = searchResults[index];
        return ListTile(
          leading: Image.network(product.thumbnail,
              width: 60, height: 60, fit: BoxFit.cover),
          title: Text(product.title),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          onTap: () async {
            await ref
                .read(ProductDetailsNotifier.provider.notifier)
                .fetchProductDetails(product.id);
            if (context.mounted) context.push(AppRoute.productDetails.path);
          },
        );
      },
    );
  }
}
