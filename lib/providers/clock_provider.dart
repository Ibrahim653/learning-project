import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';

class ClockNotifier extends PageNotifier<DateTime> {
  ClockNotifier({required super.errorHandler, required super.successHandler}) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      updateState(stateFactory.createLoaded(DateTime.now()));
    });
  }

  late final Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  static final provider =
      StateNotifierProvider<ClockNotifier, PageState<DateTime>>((ref) {
    return ClockNotifier(
      errorHandler: ref.watch(IPageErrorHandler.provider),
      successHandler: ref.watch(IPageSuccessHandler.provider),
    );
  });
}


// class Clock extends StateNotifier<DateTime> {
//   Clock() : super(DateTime.now()) {
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       state = DateTime.now();
//     });
//   }
//   late final Timer _timer;
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
// }

// final clockProvider = StateNotifierProvider<Clock, DateTime>((ref) {
//   return Clock();
// });
