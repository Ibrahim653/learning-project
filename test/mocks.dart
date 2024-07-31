// test/mocks.dart

import 'package:mockito/annotations.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/blocs/interfaces/products_interface.dart';
import 'package:riverpod_files/blocs/repos/login_repo/login_repo.dart';

@GenerateMocks([IProductsApi, IPageErrorHandler, IPageSuccessHandler,SimpleSecureData,LoginRepo])
void main() {}
