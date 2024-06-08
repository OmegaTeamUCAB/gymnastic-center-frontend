import 'package:dio/dio.dart';
import 'package:gymnastic_center/core/exception.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';

class HttpManagerImpl extends IHttpManager {
  final Dio _dio;

  HttpManagerImpl({required super.baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  @override
  Future<Result<T>> makeRequest<T>(
      {required String httpMethod,
      required String urlPath,
      required T Function(dynamic) mapperCallBack,
      Map<String, dynamic>? queryParams,
      dynamic body}) async {
    try {
      final response = await _dio.request(
          urlPath.substring(0, 1) == '/' ? urlPath : '/$urlPath',
          data: body,
          options: Options(
            method: httpMethod,
          ),
          queryParameters: queryParams);
      return Result.success<T>(mapperCallBack(response.data));
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      return Result.failure<T>(const NetworkException());
    } catch (e) {
      return Result.failure<T>(const UnknownException());
    }
  }

  @override
  void updateHeaders({required String headerKey, required headerValue}) {
    _dio.options.headers[headerKey] = headerValue;
  }
}
