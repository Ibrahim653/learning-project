import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/networking/api_constants.dart';

abstract class ICategoryApi {
  static final provider = Provider<ICategoryApi>((ref) {
   

       return CategoryApiImpl(remoteClient: ref.watch(RemoteClient.provider(null)));

  });

  Future<List<String>> fetchCategories();
}

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


