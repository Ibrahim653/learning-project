import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/networking/product_details_api.dart';

import '../models/products_model/product_details_model.dart';

abstract class IProductDetailsApi {
   static final provider = Provider<IProductDetailsApi>((ref) {
    return ProductDetailsApiImpl(remoteClient: ref.watch(RemoteClient.provider(null)));
  });
  Future<ProductDetailsModel> getProductDetails (int productId);
}