import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_files/blocs/models/products_model/product_response.dart';
import 'package:riverpod_files/networking/api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(ApiConstants.products)
  Future<ProductResponse> getProducts(
    @Query("limit") int limit,
    @Query("skip") int skip,
    @Query("select") String select,
  );
}
