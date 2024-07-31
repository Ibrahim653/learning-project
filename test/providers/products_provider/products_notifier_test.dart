
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/blocs/models/products_model/product_response.dart';
import 'package:riverpod_files/providers/products_provider/products_notifier.dart';

import '../../mocks.mocks.dart';

void main() {
  late ProductsNotifier productsNotifier;
  late MockIProductsApi mockIProductsApi;
  late MockIPageErrorHandler mockErrorHandler;
  late MockIPageSuccessHandler mockSuccessHandler;

  setUp(() {
    mockIProductsApi = MockIProductsApi();
    mockErrorHandler = MockIPageErrorHandler();
    mockSuccessHandler = MockIPageSuccessHandler();

    productsNotifier = ProductsNotifier(
      iProductsApi: mockIProductsApi,
      errorHandler: mockErrorHandler,
      successHandler: mockSuccessHandler,
    );
  });

  group('ProductsNotifier', () {
    final productResponse = ProductResponse(
      products: [
        Product(id: 1, title: 'title', price: 20.0, thumbnail: 'thumbnail'),
      ],
      total: 100,
      skip: 10,
      limit: 20,
    );

    test('fetchProducts successfully updates state with products', () async {
      // Arrange
      when(mockIProductsApi.getProducts(any, any))
          .thenAnswer((_) async => productResponse);

      // Act
      await productsNotifier.fetchProducts();

      // Assert
      final state = productsNotifier.state;
      expect(state.data, isNotNull);
      expect(state.data, isNotEmpty);
      expect(state.data!.length, equals(1));
      expect(state.data![0].title, equals('title'));
      expect(state.isLoading, isFalse);
    });

    test('fetchProducts handles errors gracefully', () async {
      // Arrange
      when(mockIProductsApi.getProducts(any, any))
          .thenThrow(Exception('Network error'));

      // Act
      await productsNotifier.fetchProducts();

      // Assert
      final state = productsNotifier.state;
      expect(state.isError, isTrue);
      expect(state.error, isNotNull);
      expect(state.isLoading, isFalse);
    });
  });
}
