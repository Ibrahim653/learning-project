import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/blocs/models/products_model/product_response.dart';
import 'package:riverpod_files/providers/providers.dart';
import '../../blocs/repos/products_repo/products_repo.dart';

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

  ProductsNotifier(this._getProductsRepo) : super([]) {
   // _fetchAllProducts(); 
  }

  bool get isLoading => _isLoading;
  int get totalProducts => _totalProducts;

  // Future<void> _fetchAllProducts() async {
  //   while (state.length < _totalProducts) {
  //     await fetchProducts();
  //   }
  // }

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




// class ProductsNotifier extends PageNotifier<List<Product>>
//     with PaginatedListNotifierMixin<PageState<List<Product>>, Product> {
//   static final provider = StateNotifierProvider.autoDispose<ProductsNotifier,
//       PageState<List<Product>>>((ref) {
//     return ProductsNotifier(
//       getProductsRepo: ProductsRepo(ref.watch(apiServiceProvider)),
//    errorHandler: ref.watch(IPageErrorHandler.provider),
//       successHandler: ref.watch(IPageSuccessHandler.provider),
//     );
//   });

//   ProductsNotifier({
//     required ProductsRepo getProductsRepo,
//     required super.errorHandler,
//     required super.successHandler,
//     this.pager = const PageConfigs(10),
//   }) : _getProductsRepo = getProductsRepo {
//     fetch();
//   }
//   final ProductsRepo _getProductsRepo;

//   @override
//   final PageConfigs pager;

//   @override
//   Future<PageList<Product>> getData(int page, int count) async {
//     final result = await _getProductsRepo.getProducts(
//       PaginationParams(
//         offset: page * count,
//         limit: count,
//       ),
//     );
//     return PageList(result.when(
//       success: (product) {
//         if (product.products.isNotEmpty) return product.products;
//         return [];
//       },
//       failure: (error) => [],
//     ));
//   }
//    Future<void> fetchProducts() async {
//     state = stateFactory.createLoading();
//     final result = await getData(currentPage, pager.pageSize);
//     if(result.items.isNotEmpty){
//     final  products=result.items;
//  state = stateFactory.createLoaded(products);
//         pager.pageSize+1;
//     }else{

//     }
//   }
// }
