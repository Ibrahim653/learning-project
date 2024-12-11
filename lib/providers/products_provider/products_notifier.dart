import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/blocs/models/products_model/product_response.dart';
import '../../blocs/interfaces/products_interface.dart';

// class ProductsNotifier extends StateNotifier<List<Product>> {
//   final ProductsRepo _getProductsRepo;
//   int _page = 0;
//   final int _limit = 10;
//   int _totalProducts = 1;
//   bool _isLoading = false;

//   ProductsNotifier(this._getProductsRepo) : super([]) {
//     // _fetchAllProducts();
//   }

//   bool get isLoading => _isLoading;
//   int get totalProducts => _totalProducts;

//   // Future<void> _fetchAllProducts() async {
//   //   while (state.length < _totalProducts) {
//   //     await fetchProducts();
//   //   }
//   // }

//   Future<void> fetchProducts() async {
//     if (_isLoading || (state.length >= _totalProducts)) {
//       return;
//     }

//     _isLoading = true;

//     try {
//       final response =
//           await _getProductsRepo.getProducts(page: _page, limit: _limit);

//       response.when(
//           success: (productResponse) {
//             _totalProducts = productResponse.total;
//             if (productResponse.products.isNotEmpty) {
//               _page++;
//               state = [...state, ...productResponse.products];
//             }
//           },
//           failure: (error) => Exception(error.toString()));
//     } catch (e) {
//       Exception(e.toString());
//     } finally {
//       _isLoading = false;
//     }
//   }

//   List<Product> searchProducts(String query) {
//     final lowerCaseQuery = query.toLowerCase();
//     return state
//         .where(
//             (product) => product.title.toLowerCase().contains(lowerCaseQuery))
//         .toList();
//   }

//   static final productsProvider =
//       StateNotifierProvider<ProductsNotifier, List<Product>>((ref) {
//     final getProductsRepo = ref.watch(getProductsRepoProvider);
//     return ProductsNotifier(getProductsRepo);
//   });
// }

/// /////

// final getProductsRepoProvider = Provider<ProductsRepo>((ref) {
//   final apiService = ref.watch(apiServiceProvider);
//   return ProductsRepo(apiService);
// });

// class ProductsNotifier extends PageNotifier<List<Product>>
//     with PaginatedListNotifierMixin<PageState<List<Product>>, Product> {
//   static final provider = StateNotifierProvider.autoDispose<ProductsNotifier,
//       PageState<List<Product>>>((ref) {
//     return ProductsNotifier(
//       getProductsRepo: ProductsRepo(ref.watch(apiServiceProvider)),
//       errorHandler: ref.watch(IPageErrorHandler.provider),
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
//   final int _limit = 10;
//   // int totalProducts = 1;

//   @override
//   Future<PageList<Product>> getData(int page, int count) async {
//     final result =
//         await _getProductsRepo.getProducts(skip: page * count, limit: _limit);

//     return PageList(result.when(
//       success: (product) {
//         return product.products;
//       },
//       failure: (error) {
//         return [];
//       },
//     ));
//   }

//   Future<void> fetchProducts() async {
//     updateState(stateFactory.createLoading());

//     try {
//       final result = await getData(currentPage, pager.pageSize);
//       final products = [...?state.data, ...result.items];
//       updateState(stateFactory.createLoaded(products));
//       pager.pageSize + 1;
//     } catch (e) {
//       updateState(stateFactory.createError(PageError.fromError(e)));
//     }
//   }

//   List<Product> searchProducts(String query) {
//     final lowerCaseQuery = query.toLowerCase();
//     return state.data!
//         .where(
//             (product) => product.title.toLowerCase().contains(lowerCaseQuery))
//         .toList();
//   }

// Future<void> fetchProducts() async {
//   state = stateFactory.createLoading();
//   final result = await getData(currentPage, pager.pageSize);
//   if (result.items.isNotEmpty) {
//     final products = result.items;
//     state = stateFactory.createLoaded(products);
//     pager.pageSize + 1;
//   }
// }

// static final productsProvider =
//     StateNotifierProvider<ProductsNotifier, PageState<List<Product>>>((ref) {
//   final getProductsRepo = ref.watch(getProductsRepoProvider);
//   return ProductsNotifier(
//     getProductsRepo: getProductsRepo,
//     errorHandler: ref.watch(IPageErrorHandler.provider),
//     successHandler: ref.watch(IPageSuccessHandler.provider),
//   );
// });
//}

// with remote client

// final getProductsRepoProvider = Provider<ProductsRepo>((ref) {
//   final apiService = ref.watch(apiServiceProvider);
//   return ProductsRepo(apiService);
// });

class ProductsNotifier extends PageNotifier<List<Product>>
    with PaginatedListNotifierMixin<PageState<List<Product>>, Product> {
  static final provider = StateNotifierProvider.autoDispose<ProductsNotifier,
      PageState<List<Product>>>((ref) {
    return ProductsNotifier(
      iProductsApi: ref.watch(IProductsApi.provider),
      errorHandler: ref.watch(IPageErrorHandler.provider),
      successHandler: ref.watch(IPageSuccessHandler.provider),
    );
  });

  ProductsNotifier({
    required IProductsApi iProductsApi,
    required super.errorHandler,
    required super.successHandler,
    this.pager = const PageConfigs(10),
  }) : _iProductsApi = iProductsApi {
    fetch();
  }
  final IProductsApi _iProductsApi;

  @override
  final PageConfigs pager;
  final int _limit = 10;
  int totalProducts = 1;

  @override
  Future<PageList<Product>> getData(int page, int count) async {
    final response = await _iProductsApi.getProducts(
      page * count,
      _limit,
    );
    totalProducts = response.total;

    return PageList(response.products);
  }

  Future<void> fetchProducts() async {
    if (state.data != null && state.data!.length >= totalProducts) return;

    updateState(stateFactory.createLoading());

    try {
      final result = await getData(currentPage, pager.pageSize);
      final products = [...?state.data, ...result.items];
      updateState(stateFactory.createLoaded(products));
      pager.pageSize + 1;
    } catch (e) {
      updateState(stateFactory.createError(PageError.fromError(e)));
    }
  }
}
