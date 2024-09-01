import 'package:block_learning/data/providers/dio_provider/dio_provider.dart';
import 'package:block_learning/config/constant/api.dart';
import 'package:get_it/get_it.dart';

class AuthenticationProvider {
  final DioProvider _dioProvider = GetIt.instance<DioProvider>();

  Future<dynamic> getToken(String username, String password) async {
    try {
      final response = await _dioProvider.post(
          path: API_AUTH_ENDPOINT,
          data: {'username': username, 'password': password});
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> refreshToken(String refresh_token) async {
    try {
      final response = await _dioProvider.post(
          path: API_REFRESH_ENDPOINT, data: {'refresh_token': refresh_token});
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
