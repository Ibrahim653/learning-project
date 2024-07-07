import 'package:riverpod_files/blocs/models/products_model/product_response.dart';
import 'package:riverpod_files/networking/api_result.dart';
import 'package:riverpod_files/networking/api_service.dart';

class ProductsRepo {
  final ApiService _apiService;

  ProductsRepo(this._apiService);

  Future<ApiResult<ProductResponse>> getProducts({required int page, required int limit}) async {
    try {
      final int skip = page * limit;
      final response = await _apiService.getProducts(limit, skip, 'title,price,thumbnail');
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(Exception(error.toString()));
    }
  }
}
