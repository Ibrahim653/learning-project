import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/blocs/interfaces/search_interface.dart';
import 'package:riverpod_files/networking/api/api_constants.dart';

import '../blocs/models/products_model/product_response.dart';

class SearchApiImpl implements ISearchApi {
    final RemoteClient remoteClient;

  SearchApiImpl({required this.remoteClient});

  @override
  Future<List<Product>> searchProducts(String query) async{
    final response = await remoteClient.request<JsonMap>(
      RemoteMethod.GET,
      ApiConstants.search,
      queryParameters: {
        'q': query,
      },
    );

    return ProductResponse.fromJson(response.data).products;
  }
  
}