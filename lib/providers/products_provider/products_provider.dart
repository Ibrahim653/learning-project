import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/blocs/models/products_model/product_response.dart';
import 'package:riverpod_files/networking/api_service.dart';
import 'package:riverpod_files/networking/dio_factory.dart';
import '../../blocs/repos/products_repo.dart';

final dioProvider = Provider<Dio>((ref) => DioFactory.getdio());

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

final getProductsRepoProvider = Provider<ProductsRepo>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ProductsRepo(apiService);
});

class ProductsNotifier extends StateNotifier<List<Product>> {
  final ProductsRepo _getProductsRepo;
  int _page = 0;
  final int _limit = 10;
  int _totalProducts = 1;
  bool _isLoading = false;

  ProductsNotifier(this._getProductsRepo) : super([]);

  bool get isLoading => _isLoading;
  int get totalProducts => _totalProducts;

  Future<void> fetchProducts() async {
    if (_isLoading || (state.length >= _totalProducts)) {
      return;
    }

    _isLoading = true;

    try {
      final response =
          await _getProductsRepo.getProducts(page: _page, limit: _limit);

      response.when(
        success: (productResponse) {
          _totalProducts = productResponse.total;
          if (productResponse.products.isNotEmpty) {
            _page++;
            state = [...state, ...productResponse.products];
          }
        },
        failure: (error) => debugPrint('Error: $error'),
      );
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      _isLoading = false;
    }
  }

  List<Product> searchProducts(String query) {
    final lowerCaseQuery = query.toLowerCase();
    return state
        .where(
            (product) => product.title.toLowerCase().contains(lowerCaseQuery))
        .toList();
  }

  static final productsProvider =
      StateNotifierProvider<ProductsNotifier, List<Product>>((ref) {
    final getProductsRepo = ref.watch(getProductsRepoProvider);
    return ProductsNotifier(getProductsRepo);
  });
}
