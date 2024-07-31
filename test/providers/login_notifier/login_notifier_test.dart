import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/blocs/models/login_models/login_response.dart';
import 'package:riverpod_files/helper/constants.dart';
import 'package:riverpod_files/providers/login_notifier/login_notifier.dart';
import 'package:riverpod_files/networking/api/api_result.dart';

import '../../mocks.mocks.dart';

void main() {
  late LoginNotifier loginNotifier;
  late MockLoginRepo mockLoginRepo;
  late MockSimpleSecureData mockSecureData;
  late MockIPageErrorHandler mockErrorHandler;
  late MockIPageSuccessHandler mockSuccessHandler;

  setUp(() {
    // Arrange: Initialize mocks and login notifier
    mockLoginRepo = MockLoginRepo();
    mockSecureData = MockSimpleSecureData();
    mockErrorHandler = MockIPageErrorHandler();
    mockSuccessHandler = MockIPageSuccessHandler();

    // Configure mock behavior for readString to return a Future<String?>
    when(mockSecureData.readString(any)).thenAnswer(
      (_) async => 'mocked_token_value',
    );

    loginNotifier = LoginNotifier(
      loginRepo: mockLoginRepo,
      secureData: mockSecureData,
      errorHandler: mockErrorHandler,
      successHandler: mockSuccessHandler,
    );
  });

  group('LoginNotifier', () {
    test('successful login', () async {
      // Arrange
      final loginResponse = LoginResponse(
        id: 1,
        username: 'testUser',
        email: 'test@example.com',
        firstName: 'Test',
        lastName: 'User',
        gender: 'male',
        image: 'image_url',
        token: 'token_value',
        refreshToken: 'refresh_token_value',
      );

      // Mock the successful login response
      when(mockLoginRepo.login(any)).thenAnswer(
        (_) async => Success(loginResponse),
      );

      // Act
      await loginNotifier.login();

      // Assert
      expect(loginNotifier.state, isA<PageState<LoginResponse>>());
      verify(mockSecureData.readString(Constants.accessToken)).called(1);
      verifyNever(mockSecureData.readString(Constants.refreshToken));
    });

    test('failed login', () async {
      // Arrange
      final error = PageError(Exception('Login failed'));

      // Mock the failed login response
      when(mockLoginRepo.login(any)).thenAnswer(
        (_) async => Failure(error),
      );

      // Act
      await loginNotifier.login();

      // Assert
      expect(loginNotifier.state, isA<ErrorPageState<LoginResponse>>());
      verifyNever(mockSecureData.readString(any));
    });
  });
}
