import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/blocs/models/login_models/login_request_body.dart';
import 'package:riverpod_files/blocs/models/login_models/login_response.dart';
import 'package:riverpod_files/blocs/repos/login_repo/login_repo.dart';
import 'package:riverpod_files/providers/providers.dart';

import '../../helper/constants.dart';
import '../../helper/shared_prefs_helper.dart';

// final loginRepoProvider = Provider<LoginRepo>((ref) {
//   final apiService = ref.watch(apiServiceProvider);
//   return LoginRepo(apiService);
// });

// class LoginNotifier extends StateNotifier<AsyncValue<LoginResponse?>> {
//   final LoginRepo _loginRepo;

//   LoginNotifier(this._loginRepo) : super(const AsyncValue.data(null));
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   Future<void> login() async {
//     state = const AsyncValue.loading();
//     final loginRequestBody = LoginRequestBody(
//         username: usernameController.text, password: passwordController.text);
//     final response = await _loginRepo.login(loginRequestBody);

//     response.when(
//       success: (loginResponse) async {
//         await CacheHelper.setSecuredString(
//             Constants.accessToken, loginResponse.token);
//         await CacheHelper.setSecuredString(
//             Constants.accessToken, loginResponse.refreshToken);

//         state = AsyncValue.data(loginResponse);
//       },
//       failure: (error) => state = AsyncValue.error(error, StackTrace.current),
//     );
//   }

//   static final provider =
//       StateNotifierProvider<LoginNotifier, AsyncValue<LoginResponse?>>((ref) {
//     final loginRepo = ref.watch(loginRepoProvider);
//     return LoginNotifier(loginRepo);
//   });
// }

class LoginNotifier extends PageNotifier<LoginResponse> {
  static final provider =
      StateNotifierProvider<LoginNotifier, PageState<LoginResponse>>((ref) {
    final apiService = ref.watch(apiServiceProvider);

    return LoginNotifier(
      LoginRepo(apiService),
      errorHandler: ref.watch(IPageErrorHandler.provider),
      successHandler: ref.watch(IPageSuccessHandler.provider),
    );
  });
  LoginNotifier(this._loginRepo,
      {required super.errorHandler, required super.successHandler}) {
    updateState(stateFactory.createVoid());
  }
  final LoginRepo _loginRepo;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    state = stateFactory.createLoading();
    final loginRequestBody = LoginRequestBody(
        username: usernameController.text, password: passwordController.text);
    final response = await _loginRepo.login(loginRequestBody);
    response.when(
      success: (loginResponse) async {
        await CacheHelper.setSecuredString(
            Constants.accessToken, loginResponse.token);
        await CacheHelper.setSecuredString(
            Constants.accessToken, loginResponse.refreshToken);

        state = stateFactory.createLoaded(loginResponse);
      },
      failure: (error) =>
          state = stateFactory.createError(PageError.fromError(error)),
    );
  }
}
