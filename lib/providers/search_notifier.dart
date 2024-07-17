import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/blocs/interfaces/search_interface.dart';
import 'package:riverpod_files/blocs/models/products_model/product_response.dart';

class SearchNotifier extends PageNotifier<List<Product>> {
  static final provider = StateNotifierProvider.autoDispose<SearchNotifier, PageState<List<Product>>>((ref) {
    return SearchNotifier(
      iSearchApi: ref.watch(ISearchApi.provider),
      errorHandler: ref.watch(IPageErrorHandler.provider),
      successHandler: ref.watch(IPageSuccessHandler.provider),
    );
  });

  SearchNotifier({
    required ISearchApi iSearchApi,
    required super.errorHandler,
    required super.successHandler,
  }) : _iSearchApi = iSearchApi;

  final ISearchApi _iSearchApi;

  Future<void> searchProducts(String query) async {
    updateState(stateFactory.createLoading());

    try {
      final products = await _iSearchApi.searchProducts(query);
      updateState(stateFactory.createLoaded(products));
    } catch (e) {
      updateState(stateFactory.createError(PageError.fromError(e)));
    }
  }

  void clearResults() {
    updateState(stateFactory.createLoaded([]));
  }
}
