import 'package:gymnastic_center/core/result.dart';

abstract class IHttpManager {
  final String baseUrl;

  IHttpManager({required this.baseUrl});

  Future<Result<T>> makeRequest<T>({
    required String httpMethod,
    required String urlPath,
    required T Function(dynamic) mapperCallBack,
    Map<String, dynamic>? queryParams,
    dynamic body,
  });

  void updateHeaders({required String headerKey, required dynamic headerValue});
}
