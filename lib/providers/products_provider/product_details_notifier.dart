import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import '../../blocs/interfaces/product_details_interface.dart';
import '../../blocs/models/products_model/product_details_model.dart';

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

// class ProductDetailsNotifier extends PageNotifier<ProductDetailsModel> {
//   static final provider = StateNotifierProvider.family
//       .autoDispose<ProductDetailsNotifier, PageState<ProductDetailsModel>, int>(
//           (ref, id) {
//     final productDetailsRepo = ref.watch(productDetailsRepoProvider);
//     return ProductDetailsNotifier(
//       id,
//       productDetailsRepo: productDetailsRepo,
//       errorHandler: ref.watch(IPageErrorHandler.provider),
//       successHandler: ref.watch(IPageSuccessHandler.provider),
//     );
//   });

//   ProductDetailsNotifier(
//     this.id, {
//     required this.productDetailsRepo,
//     required super.errorHandler,
//     required super.successHandler,
//   }) : super() {
//     fetchProductDetails();
//   }

//   final ProductDetailsRepo productDetailsRepo;
//   final int id;
//   Future<void> fetchProductDetails() async {
//     update(() async {
//       final productDetails = await productDetailsRepo.getProductDetails(id);
//       return productDetails.when(
//         success: (details) {
//           return stateFactory.createLoaded(details);
//         },
//         failure: (error) {
//           return stateFactory.createError(PageError.fromError(error));
//         },
//       );
//     });
//   }
// }

// with remote client

class ProductDetailsNotifier extends PageNotifier<ProductDetailsModel> {
  static final provider = StateNotifierProvider.family
      .autoDispose<ProductDetailsNotifier, PageState<ProductDetailsModel>, int>(
          (ref, id) {
    return ProductDetailsNotifier(
      id,
      iProductDetailsApi: ref.watch(IProductDetailsApi.provider),
      errorHandler: ref.watch(IPageErrorHandler.provider),
      successHandler: ref.watch(IPageSuccessHandler.provider),
    );
  });

  ProductDetailsNotifier(
    this.productId, {
    required this.iProductDetailsApi,
    required super.errorHandler,
    required super.successHandler,
  }) : super() {
    fetchProductDetails();
  }

  final IProductDetailsApi iProductDetailsApi;
  final int productId;

  Future<void> fetchProductDetails() async {
    updateState(stateFactory.createLoading());

    try {
      final productDetails =
          await iProductDetailsApi.getProductDetails(productId);
      updateState(stateFactory.createLoaded(productDetails));
    } catch (e) {
      updateState(stateFactory.createError(PageError.fromError(e)));
    }
  }
}
