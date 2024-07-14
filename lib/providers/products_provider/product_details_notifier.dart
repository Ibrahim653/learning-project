import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import '../../blocs/models/products_model/product_details_model.dart';
import '../../blocs/repos/products_repo/product_details_repo.dart';

// final productDetailsRepoProvider = Provider<ProductDetailsRepo>((ref) {
//   final apiService = ref.watch(apiServiceProvider);
//   return ProductDetailsRepo(apiService);
// });

// class ProductDetailsNotifier extends StateNotifier<AsyncValue<ProductDetailsModel?>> {
//   final ProductDetailsRepo productDetailsRepo;

//   ProductDetailsNotifier(this.productDetailsRepo)
//       : super(const AsyncValue.data(null));

//   Future<void> fetchProductDetails(int productId) async {
//     state = const AsyncValue.loading();
//     print('Fetching product details for product ID: $productId');

//     final productDetails = await productDetailsRepo.getProductDetails(productId);
//     productDetails.when(
//       success: (productDetails) {
//         print('Successfully fetched product details: $productDetails');
//         state = AsyncValue.data(productDetails);
//       },
//       failure: (error) {
//         print('Failed to fetch product details: $error');
//         state = AsyncValue.error(error, StackTrace.current);
//       },
//     );
//   }

//   static final provider = StateNotifierProvider<ProductDetailsNotifier, AsyncValue<ProductDetailsModel?>>((ref) {
//     final productDetailsRepo = ref.watch(productDetailsRepoProvider);
//     return ProductDetailsNotifier(productDetailsRepo);
//   });
// }

class ProductDetailsNotifier extends PageNotifier<ProductDetailsModel> {
  static final provider = StateNotifierProvider<ProductDetailsNotifier,
      PageState<ProductDetailsModel>>((ref) {
    final productDetailsRepo = ref.watch(productDetailsRepoProvider);
    return ProductDetailsNotifier(
      productDetailsRepo: productDetailsRepo,
      errorHandler: ref.watch(IPageErrorHandler.provider),
      successHandler: ref.watch(IPageSuccessHandler.provider),
    );
  });

  ProductDetailsNotifier({
    required this.productDetailsRepo,
    required super.errorHandler,
    required super.successHandler,
  }) : super();

  final ProductDetailsRepo productDetailsRepo;

  Future<void> fetchProductDetails(int productId) async {
    update(() async {
      print('Fetching product details for product ID: $productId');
      final productDetails =
          await productDetailsRepo.getProductDetails(productId);
      return productDetails.when(
        success: (details) {
          print('Successfully fetched product details: $details');
          return stateFactory.createLoaded(details);
        },
        failure: (error) {
          print('Failed to fetch product details: $error');
          return stateFactory.createError(PageError.fromError(error));
        },
      );
    });
  }
}
