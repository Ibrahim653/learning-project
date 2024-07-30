import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kortobaa_core_package/kortobaa_core_package.dart';
import 'package:riverpod_files/blocs/models/login_models/login_response.dart';
import 'package:riverpod_files/blocs/models/login_models/login_request_body.dart';
import 'package:riverpod_files/blocs/repos/login_repo/login_repo.dart';
import 'package:riverpod_files/helper/constants.dart';
import 'package:riverpod_files/networking/api/api_result.dart';
import 'package:riverpod_files/providers/login_notifier/login_notifier.dart';

// Define mock classes
class MockLoginRepo extends Mock implements LoginRepo {}

class MockSimpleSecureData extends Mock implements SimpleSecureData {}

class MockPageErrorHandler extends Mock implements IPageErrorHandler {}

class MockPageSuccessHandler extends Mock implements IPageSuccessHandler {}

// Define a fake class for LoginRequestBody
class FakeLoginRequestBody extends Fake implements LoginRequestBody {}

void main() {
  late LoginNotifier loginNotifier;
  late MockLoginRepo mockLoginRepo;
  late MockSimpleSecureData mockSecureData;
  late MockPageErrorHandler mockErrorHandler;
  late MockPageSuccessHandler mockSuccessHandler;

  // Register the fake for LoginRequestBody
  setUpAll(() {
    registerFallbackValue(FakeLoginRequestBody());
  });

  setUp(() {
    // Initialize mocks and login notifier
    mockLoginRepo = MockLoginRepo();
    mockSecureData = MockSimpleSecureData();
    mockErrorHandler = MockPageErrorHandler();
    mockSuccessHandler = MockPageSuccessHandler();

    // Configure mock behavior for readString to return a Future<String?>
    when(() => mockSecureData.readString(any())).thenAnswer(
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
      when(() => mockLoginRepo.login(any())).thenAnswer(
        (_) async => Success(loginResponse),
      );

      await loginNotifier.login();

      expect(loginNotifier.state, isA<PageState<LoginResponse>>());

      // Verify that secureData.readString is called
      verify(() => mockSecureData.readString(Constants.accessToken)).called(1);
    });

    test('failed login', () async {
      final error = PageError(Exception('Login failed'));

      // Mock the failed login response
      when(() => mockLoginRepo.login(any())).thenAnswer(
        (_) async => Failure(error),
      );

      await loginNotifier.login();

      expect(loginNotifier.state, isA<ErrorPageState<LoginResponse>>());
      verifyNever(() => mockSecureData.readString(any()));
    });
  });
}
