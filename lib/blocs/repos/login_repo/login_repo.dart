import '../../../networking/api/api_result.dart';
import '../../../networking/api/api_service.dart';
import '../../models/login_models/login_request_body.dart';
import '../../models/login_models/login_response.dart';

class LoginRepo {
  final ApiService _apiService;

  LoginRepo(this._apiService);

  Future<ApiResult<LoginResponse>> login(
      LoginRequestBody loginRequestBody) async {
    try {
      final LoginResponse response = await _apiService.login(loginRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(Exception(error.toString()));
    }
  }
}
