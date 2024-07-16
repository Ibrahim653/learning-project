import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/networking/api_constants.dart';

import '../blocs/interfaces/category_interface.dart';



class CategoryApiImpl implements ICategoryApi {
  final RemoteClient remoteClient;

  CategoryApiImpl({required this.remoteClient});

  @override
  Future<List<String>> fetchCategories() async {
    final response = await remoteClient.request(
      RemoteMethod.GET,
      ApiConstants.getCategoryList,
      responseType: ResponseType.json,
    );

    return List<String>.from(response.data);
  }
}


