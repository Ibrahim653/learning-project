import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final cartProducts = ref.watch(cartNotifierProvider);
    final totalPrice = ref.watch(cartTotalProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: cartProducts.map((product) {
                  return Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Image.asset(product.image, width: 60, height: 60),
                        const SizedBox(width: 10),
                        Text('${product.title}...'),
                        const Expanded(child: SizedBox()),
                        Text('£${product.price}'),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            ref
                                .read(cartNotifierProvider.notifier)
                                .removeProductFromCart(product);
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Text('Total Price : £$totalPrice')
          ],
        ),
      ),
    );
  }
}
