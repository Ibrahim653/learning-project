import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';

import '../../networking/category_api.dart';

abstract class ICategoryApi {
  static final provider = Provider<ICategoryApi>((ref) {
   

       return CategoryApiImpl(remoteClient: ref.watch(RemoteClient.provider(null)));

  });

  Future<List<String>> fetchCategories();
}