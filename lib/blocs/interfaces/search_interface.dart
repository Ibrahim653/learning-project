import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/networking/search_api.dart';

import '../models/products_model/product_response.dart';

abstract class ISearchApi {
    static final provider = Provider<ISearchApi>((ref) {
    return SearchApiImpl(remoteClient: ref.watch(RemoteClient.provider(null)));
  });
  Future<List<Product>> searchProducts(String query);
}
