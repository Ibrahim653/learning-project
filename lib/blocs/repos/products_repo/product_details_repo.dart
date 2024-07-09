

import 'package:riverpod_files/blocs/models/products_model/product_details_model.dart';

import '../../../networking/api_result.dart';
import '../../../networking/api_service.dart';

class ProductDetailsRepo {
  final ApiService _apiService;

  ProductDetailsRepo(this._apiService);

  Future<ApiResult<ProductDetailsModel>> getProductDetails(int id) async {
    try {
  
      final response = await _apiService.getProductDetails(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(Exception(error.toString()));
    }
  }
}