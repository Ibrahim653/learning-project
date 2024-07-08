import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/networking/api_service.dart';
import 'package:riverpod_files/networking/dio_factory.dart';
import '../blocs/repos/login_repo/login_repo.dart';
import '../blocs/repos/products_repo/products_repo.dart';

final dioProvider = Provider<Dio>((ref) => DioFactory.getdio());

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

final getProductsRepoProvider = Provider<ProductsRepo>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ProductsRepo(apiService);
});

final loginRepoProvider = Provider<LoginRepo>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return LoginRepo(apiService);
});


