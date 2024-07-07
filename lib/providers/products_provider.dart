import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/generated/locale_keys.g.dart';

import '../blocs/models/product.dart';

const List<Product> allProducts = [
  Product(id: '1', title: LocaleKeys.products_groovy_shorts, price: 12, image: 'assets/products/shorts.png'),
  Product(id: '2', title: LocaleKeys.products_karati_kit, price: 34, image: 'assets/products/karati.png'),
  Product(id: '3', title: LocaleKeys.products_denim_jeans, price: 54, image: 'assets/products/jeans.png'),
  Product(id: '4', title: LocaleKeys.products_red_backpack, price: 14, image: 'assets/products/backpack.png'),
  Product(id: '5', title: LocaleKeys.products_drum_sticks, price: 29, image: 'assets/products/drum.png'),
  Product(id: '6', title: LocaleKeys.products_blue_suitcase, price: 44, image: 'assets/products/suitcase.png'),
  Product(id: '7', title: LocaleKeys.products_roller_skates, price: 52, image: 'assets/products/skates.png'),
  Product(id: '8', title: LocaleKeys.products_electric_guitar, price: 79, image: 'assets/products/guitar.png'),
];
final allProductsProvider =Provider((ref){
  return allProducts;
});

