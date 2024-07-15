import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/networking/api_constants.dart';
import 'package:riverpod_files/blocs/models/products_model/product_response.dart';

abstract class INewApi {
  static final provider = Provider<INewApi>((ref) {
    return NewApiImpl(remoteClient: ref.watch(RemoteClient.provider(null)));
  });

  Future<ProductResponse> getProducts(int skip, int limit);
}

class NewApiImpl implements INewApi {
  final RemoteClient remoteClient;

  NewApiImpl({required this.remoteClient});

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
