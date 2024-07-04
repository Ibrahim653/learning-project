import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/products_provider.dart';
import 'package:riverpod_files/screens/home/language_button.dart';
import 'package:riverpod_files/shared/cart_icon.dart';

import '../../generated/locale_keys.g.dart';
import '../../providers/cart_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final allProductProvider = ref.watch(allProductsProvider);
    final cartProducts = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home_screen_title.tr()),
        actions: const [
          CartIcon(),
          LanguageButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.withOpacity(0.05),
              child: Column(
                children: [
                  Image.asset(
                    allProductProvider[index].image,
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                  Text(allProductProvider[index].title),
                  const Expanded(child: SizedBox()),
                  if (cartProducts.contains(allProducts[index]))
                    TextButton(
                        onPressed: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .removeProductFromCart(allProducts[index]);
                        },
                        child: const Text('remove from cart')),
                  if (!cartProducts.contains(allProducts[index]))
                    TextButton(
                        onPressed: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .addProductToCart(allProducts[index]);
                        },
                        child: const Text('Add To Cart')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
