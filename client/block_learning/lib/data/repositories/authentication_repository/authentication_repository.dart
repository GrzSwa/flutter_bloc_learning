import 'package:block_learning/data/models/token_model/token_model.dart';
import 'package:block_learning/data/providers/authentication_provider/authentication_provider.dart';

class AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider;

  AuthenticationRepository(this._authenticationProvider);

  Future<TokenModel> logIn(String username, String password) async {
    try {
      // final response =
      //     await _authenticationProvider.getToken(username, password);
      // return TokenModel(
      //     access_token: response.data['access_token'],
      //     refresh_token: response.data['refresh_token']);
      return TokenModel(
          access_token: 'secret_access_token',
          refresh_token: 'secret_refresh_token');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> refresh(String refresh_token) async {
    try {
      final response =
          await _authenticationProvider.refreshToken(refresh_token);
      return response.data['access_token'];
    } catch (e) {
      throw Exception(e);
    }
  }
}
