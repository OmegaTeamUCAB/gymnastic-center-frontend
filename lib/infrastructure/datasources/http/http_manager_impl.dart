import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/core/result.dart';
import 'package:gymnastic_center/infrastructure/datasources/http/http_manager.dart';

class HttpManagerImpl extends IHttpManager {
  final Dio _dio;

  HttpManagerImpl({required super.baseUrl}) : _dio = Dio();

  @override
  Future<Result<T>> makeRequest<T>(
      {required String httpMethod,
      required String urlPath,
      required T Function(dynamic) mapperCallBack,
      Map<String, dynamic>? queryParams,
      dynamic body}) async {
    try {
      final response = await _dio.request(urlPath,
          data: body,
          options: Options(
            method: httpMethod,
          ),
          queryParameters: queryParams);
      return Result.success<T>(mapperCallBack(response.data['data']));
    } on DioException catch (e) {
      return Result.failure<T>(Error());
    } catch (e) {
      return Result.failure<T>(Error());
    }
  }

  @override
  void updateHeaders({required String headerKey, required headerValue}) {
    _dio.options.headers[headerKey] = headerValue;
  }
}
