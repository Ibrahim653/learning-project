import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/providers/products_provider.dart';
import 'package:riverpod_files/shared/cart_icon.dart';
import '../../helper/locale.dart';

import '../../generated/locale_keys.g.dart';
import '../../providers/cart_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProductProvider = ref.watch(allProductsProvider);
    final cartProducts = ref.watch(CartNotifier.provider);
   final products= cartProducts.when(
      onData: (value) => value,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.greeting.tr()),
        actions: [
          const CartIcon(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            onPressed: () {
              final currentLangCode = context.locale.languageCode;
              currentLangCode == AppLocale.english.languageCode
                  ? context.setLocale(AppLocale.arabic)
                  : context.setLocale(AppLocale.english);
            },
            child: const Icon(Icons.language_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: allProductProvider.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final product = allProductProvider[index];
            return Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.withOpacity(0.05),
              child: Column(
                children: [
                  Image.asset(
                    product.image,
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                  Text(product.title.tr()),
                  const Expanded(child: SizedBox()),
                  if (products!.contains(product))
                    TextButton(
                      onPressed: () {
                        ref
                            .read(CartNotifier.provider.notifier)
                            .removeProductFromCart(product);
                      },
                      child: const Text('Remove from cart'),
                    ),
                  if (!products.contains(product))
                    TextButton(
                      onPressed: () {
                        ref
                            .read(CartNotifier.provider.notifier)
                            .addProductToCart(product);
                      },
                      child: const Text('Add To Cart'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
