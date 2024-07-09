import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/networking/api_service.dart';
import 'package:riverpod_files/networking/dio_factory.dart';

final dioProvider = Provider<Dio>((ref) => DioFactory.getdio());

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});


