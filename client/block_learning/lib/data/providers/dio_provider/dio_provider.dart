import 'package:block_learning/config/constant/api.dart';
import 'package:dio/dio.dart';

class DioProvider {
  final Dio dio = Dio(BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 40),
      headers: {
        'Content-Type': 'application/json',
      }));

  Future<Response> get({required String path}) async {
    try {
      final response = await dio.get(path);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to GET: $e');
    }
  }

  Future<Response> post(
      {required String path, required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to POST: $e');
    }
  }
}
