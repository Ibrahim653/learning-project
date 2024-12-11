import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../blocs/models/product.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';

class CartNotifier extends PageNotifier<Set<Product>> {
  CartNotifier({required super.errorHandler, required super.successHandler}) {
    updateState(stateFactory.createLoaded(<Product>{}));
  }

  void addProductToCart(Product product) {
    state = stateFactory.createLoading();
    state.when(
      onData: (data) {
        if (!data.contains(product)) {
          final updatedData = {...data, product};
          updateState(stateFactory.createLoaded(updatedData));
        }
      },
      onOther: (_) => updateState(stateFactory.createLoaded({product})),
    );
  }

  void removeProductFromCart(Product product) {
    state = stateFactory.createLoading();
    state.when(
      onData: (data) {
        if (data.contains(product)) {
          final updatedData = data.where((p) => p.id != product.id).toSet();
          updateState(stateFactory.createLoaded(updatedData));
        }
      },
      onOther: (_) => updateState(stateFactory.createLoaded({})),
    );
  }

  static final provider =
      StateNotifierProvider<CartNotifier, PageState<Set<Product>>>((ref) {
    return CartNotifier(
      errorHandler: ref.watch(IPageErrorHandler.provider),
      successHandler: ref.watch(IPageSuccessHandler.provider),
    );
  });
}

final cartTotalProvider = Provider<int>((ref) {
  final cartProducts = ref.watch(CartNotifier.provider);
  int totalPrice = 0;
  cartProducts.when(
    onData: (products) {
      for (Product product in products) {
        totalPrice += product.price;
      }
    },
  );
  return totalPrice;
});







// class CartNotifier extends StateNotifier<Set<Product>> {
//   CartNotifier() : super({});

//   void addProductToCart(Product product) {
//     if (!state.contains(product)) {
//       state = {...state, product};
//     }
//   }

//   void removeProductFromCart(Product product) {
//     if (state.contains(product)) {
//       state = state.where((p) {
//         return p.id != product.id;
//       }).toSet();
//     }
//   }
// static  final provider =
//     StateNotifierProvider<CartNotifier, Set<Product>>((ref) {
//   return CartNotifier();
// });
// }



// final cartTotalProvider = Provider<int>((ref) {
//   final cartProducts = ref.watch(CartNotifier.provider);
//   int totalPrice = 0;
//   for (Product product in cartProducts) {
//     totalPrice += product.price;
//   }
//   return totalPrice;
// });

