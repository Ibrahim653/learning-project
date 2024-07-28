import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/blocs/interfaces/product_details_interface.dart';
import 'package:riverpod_files/blocs/models/products_model/product_details_model.dart';
import 'package:riverpod_files/networking/api/api_constants.dart';

class ProductDetailsApiImpl implements IProductDetailsApi {
  final RemoteClient remoteClient;

  ProductDetailsApiImpl({required this.remoteClient});
  @override
  Future<ProductDetailsModel> getProductDetails(int productId) async {
    final response = await remoteClient.request<JsonMap>(
      RemoteMethod.GET,
      ApiConstants.getProductDetails.replaceFirst('{id}', productId.toString()),
    );

    return ProductDetailsModel.fromJson(response.data);
  }
}
