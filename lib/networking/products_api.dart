import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/networking/api/api_constants.dart';
import 'package:riverpod_files/blocs/models/products_model/product_response.dart';

import '../blocs/interfaces/products_interface.dart';



class ProductsApiImpl implements IProductsApi {
  final RemoteClient remoteClient;

  ProductsApiImpl({required this.remoteClient});

  @override
  Future<ProductResponse> getProducts(int skip, int limit) async {
    final response = await remoteClient.request<JsonMap>(
      RemoteMethod.GET,
      ApiConstants.products,
      queryParameters: {
        'limit': limit,
        'skip': skip,
        'select': 'title,price,thumbnail',
      },
    );

    return ProductResponse.fromJson(response.data);
  }
}
