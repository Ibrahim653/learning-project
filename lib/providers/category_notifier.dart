import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import '../blocs/interfaces/category_interface.dart';

class CategoryNotifier extends PageNotifier<List<String>> {
  static final provider = StateNotifierProvider<CategoryNotifier, PageState<List<String>>>((ref) {
    return CategoryNotifier(
      categoryApi: ref.watch(ICategoryApi.provider),
      errorHandler: ref.watch(IPageErrorHandler.provider),
      successHandler: ref.watch(IPageSuccessHandler.provider),
    );
  });

  final ICategoryApi categoryApi;

  CategoryNotifier({
    required this.categoryApi,
    required super.errorHandler,
    required super.successHandler,
  }) {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    updateState(stateFactory.createLoading());
    try {
      final categories = await categoryApi.fetchCategories();
      updateState(stateFactory.createLoaded(categories));
    } catch (e) {
      updateState(stateFactory.createError(PageError.fromError(e)));
    }
  }
}
