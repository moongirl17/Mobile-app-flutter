import 'package:dio/dio.dart';
import 'package:flutter_batch_6_project/data/remote_data/auth_remote_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_classes.mocks.dart';

void main() {

  late MockNetworkService networkService;
  late AuthRemoteData authRemoteData;

  setUp(() {
    networkService = MockNetworkService();
    authRemoteData = AuthRemoteDataImpl(networkService);
  });

  group("Unit Test AuthRemoteData::postLogin()", () {

    test("Mengembalikan User Data jika Login Sukses", () async {
      const email = "admin@gmail.com";
      const password = "123456";
      const path = "/api/auth/login";

      final mockResponseData = {
        "data": {
          "user": {
            "id": 1,
            "name": "Admin",
            "email": "admin@gmail.com",
          },
          "access_token": "randomAccessToken",
        }
      };

      final mockResponse = Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
        data: mockResponseData
      );

      when(networkService.post(
        url: path,
        data: anyNamed('data'),
      )).thenAnswer((_) async => mockResponse);

      final result = await authRemoteData.postLogin(email, password);

      expect(result.accessToken, mockResponseData["data"]!["access_token"]);
      expect(result.user?.id, 1);
      expect(result.user?.name, "Admin");
      expect(result.user?.email, "admin@gmail.com");

      verify(networkService.post(
        url: path,
        data: {
          "email": email,
          "password": password,
        },
      )).called(1);

    });

    test("Throw Error jika Login Gagal", () {
      const email = "admin@gmail.com";
      const password = "123456";
      const path = "/api/auth/login";

      when(networkService.post(
        url: path,
        data: anyNamed('data'),
      )).thenThrow(Exception("Login Failed"));

      expect(() => authRemoteData.postLogin(email, password), throwsException);

      verify(networkService.post(
        url: path,
        data: {
          "email": email,
          "password": password,
        },
      )).called(1);

    });

  });

}