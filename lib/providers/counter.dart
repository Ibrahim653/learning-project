import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';

class CounterNotifier extends PageNotifier<int> {
  static final provider =
      StateNotifierProvider.autoDispose<CounterNotifier, PageState<int>>((ref) {
    return CounterNotifier(
      errorHandler: ref.watch(IPageErrorHandler.provider),
      successHandler: ref.watch(IPageSuccessHandler.provider),
    );
  });

  CounterNotifier(
      {required super.errorHandler, required super.successHandler}) {
    updateState(stateFactory.createLoaded(0));
  }
  void increment() {
    update(() async {
      // await Future.delayed(const Duration(milliseconds: 300));
      return stateFactory.createLoaded(safeData.orElse(0) + 1);
    });
  }
}
