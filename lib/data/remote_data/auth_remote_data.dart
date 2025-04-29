import 'package:flutter_batch_6_project/data/remote_data/network_service/network_service.dart';
import 'package:flutter_batch_6_project/models/auth_response_model.dart';
import 'package:flutter_batch_6_project/models/user_model.dart';

abstract class AuthRemoteData {
  Future<AuthResponseModel> postLogin(String email, String password);
  Future<User> getProfile();
}

class AuthRemoteDataImpl implements AuthRemoteData {

  late final NetworkService _networkService;

  AuthRemoteDataImpl(this._networkService);

  @override
  Future<AuthResponseModel> postLogin(String email, String password) async {
    final response = await _networkService.post(
      url: "/api/auth/login",
      data: {
        "email": email,
        "password": password,
      },
    );
    return AuthResponseModel.fromJson(response.data['data']);
  }

  @override
  Future<User> getProfile() async {
    final response = await _networkService.get(
      url: "/api/profile/me",
    );
    return User.fromJson(response.data['data']);
  }

}