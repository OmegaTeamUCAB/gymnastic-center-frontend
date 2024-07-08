import 'package:dio/dio.dart';
import 'package:gymnastic_center/core/exception.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';

class HttpManagerImpl extends IHttpManager {
  final Dio _dio;

  HttpManagerImpl() : _dio = Dio();

  @override
  Future<Result<T>> makeRequest<T>(
      {required String httpMethod,
      required String urlPath,
      required T Function(dynamic) mapperCallBack,
      Map<String, dynamic>? queryParams,
      dynamic body}) async {
    try {
      final path = urlPath.substring(0, 1) == '/' ? urlPath : '/$urlPath';
      final url = Environment.getApiUrl() + path;
      print(url);
      final response = await _dio.request(url,
          data: body,
          options: Options(
            method: httpMethod,
          ),
          queryParameters: queryParams);
      return Result.success<T>(mapperCallBack(response.data));
    } on DioException catch (e) {
      print('DioException: $e');
      return Result.failure<T>(const NetworkException());
    } catch (e) {
      print('Exception: $e');
      return Result.failure<T>(const UnknownException());
    }
  }

  @override
  void updateHeaders({required String headerKey, required headerValue}) {
    _dio.options.headers[headerKey] = headerValue;
  }
}
