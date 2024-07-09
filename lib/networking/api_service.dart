import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_files/blocs/models/login_models/login_request_body.dart';
import 'package:riverpod_files/blocs/models/login_models/login_response.dart';
import 'package:riverpod_files/blocs/models/products_model/product_response.dart';
import 'package:riverpod_files/networking/api_constants.dart';

import '../blocs/models/products_model/product_details_model.dart';

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

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginModel);

  @GET(ApiConstants.getProductDetails)
  Future<ProductDetailsModel> getProductDetails(
    @Path('id') int id,
  );

}
