import 'package:riverpod_files/blocs/models/products_model/product_response.dart';
import 'package:riverpod_files/networking/api/api_result.dart';
import 'package:riverpod_files/networking/api/api_service.dart';

class ProductsRepo {
  final ApiService _apiService;

  ProductsRepo(this._apiService);

  Future<ApiResult<ProductResponse>> getProducts({required int skip, required int limit}) async {
    try {
      final response = await _apiService.getProducts(limit, skip, 'title,price,thumbnail');
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(Exception(error.toString()));
    }
  }
}
