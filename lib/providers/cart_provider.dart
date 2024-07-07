import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../blocs/models/product.dart';

class CartNotifier extends StateNotifier<Set<Product>> {
  CartNotifier() : super({});

  void addProductToCart(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  void removeProductFromCart(Product product) {
    if (state.contains(product)) {
      state = state.where((p) {
        return p.id != product.id;
      }).toSet();
    }
  }
static  final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, Set<Product>>((ref) {
  return CartNotifier();
});
}



final cartTotalProvider = Provider<int>((ref) {
  final cartProducts = ref.watch(CartNotifier.cartNotifierProvider);
  int totalPrice = 0;
  for (Product product in cartProducts) {
    totalPrice += product.price;
  }
  return totalPrice;
});

