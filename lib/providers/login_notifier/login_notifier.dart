import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/blocs/models/login_models/login_request_body.dart';
import 'package:riverpod_files/blocs/models/login_models/login_response.dart';
import 'package:riverpod_files/blocs/repos/login_repo/login_repo.dart';
import 'package:riverpod_files/providers/providers.dart';

import '../../helper/constants.dart';
import '../../helper/shared_prefs_helper.dart';

class LoginNotifier extends StateNotifier<AsyncValue<LoginResponse?>> {
  final LoginRepo _loginRepo;

  LoginNotifier(this._loginRepo) : super(const AsyncValue.data(null));
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    state = const AsyncValue.loading();
    final loginRequestBody = LoginRequestBody(
        username: usernameController.text, password: passwordController.text);
    final response = await _loginRepo.login(loginRequestBody);

    response.when(
      success: (loginResponse) async {
        await CacheHelper.saveString(
            Constants.accessToken, loginResponse.token);
        await CacheHelper.saveString(
            Constants.accessToken, loginResponse.refreshToken);

        state = AsyncValue.data(loginResponse);
      },
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }
}

final loginNotifierProvider =
    StateNotifierProvider<LoginNotifier, AsyncValue<LoginResponse?>>((ref) {
  final loginRepo = ref.watch(loginRepoProvider);
  return LoginNotifier(loginRepo);
});
