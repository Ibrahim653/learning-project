import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/blocs/models/login_models/login_request_body.dart';
import 'package:riverpod_files/blocs/models/login_models/login_response.dart';
import 'package:riverpod_files/blocs/repos/login_repo/login_repo.dart';
import 'package:riverpod_files/providers/providers.dart';

import '../../helper/constants.dart';

class LoginNotifier extends PageNotifier<LoginResponse> {
  static final provider =
      StateNotifierProvider<LoginNotifier, PageState<LoginResponse>>((ref) {
    final apiService = ref.watch(apiServiceProvider);

    return LoginNotifier(
      loginRepo: LoginRepo(apiService),
      secureData: ref.watch(SimpleSecureData.provider),
      errorHandler: ref.watch(IPageErrorHandler.provider),
      successHandler: ref.watch(IPageSuccessHandler.provider),
    );
  });

  LoginNotifier({
    required this.loginRepo,
    required this.secureData,
    required super.errorHandler,
    required super.successHandler,
  }) {
    updateState(stateFactory.createVoid());
  }

  final LoginRepo loginRepo;
  final SimpleSecureData secureData;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    state = stateFactory.createLoading();
    final loginRequestBody = LoginRequestBody(
        username: usernameController.text, password: passwordController.text);
    final response = await loginRepo.login(loginRequestBody);

    response.when(
      success: (loginResponse) async {
        await secureData.readString(Constants.accessToken);
        await secureData.readString(Constants.refreshToken);

        state = stateFactory.createLoaded(loginResponse);
      },
      failure: (error) =>
          state = stateFactory.createError(PageError.fromError(error)),
    );
  }
}
