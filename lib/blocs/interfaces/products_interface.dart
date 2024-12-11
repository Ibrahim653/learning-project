import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';

import '../../networking/products_api.dart';
import '../models/products_model/product_response.dart';

abstract class IProductsApi {
  static final provider = Provider<IProductsApi>((ref) {
    return ProductsApiImpl(remoteClient: ref.watch(RemoteClient.provider(null)));
  });

  Future<ProductResponse> getProducts(int skip, int limit);
}