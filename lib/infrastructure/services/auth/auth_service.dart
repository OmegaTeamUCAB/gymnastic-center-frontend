import 'dart:convert';
import 'package:gymnastic_center/application/services/datasources/local_datasource.dart';
import 'package:gymnastic_center/core/exception.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/auth/auth_repository.dart';
import 'package:gymnastic_center/domain/auth/user.dart';
import 'package:gymnastic_center/infrastructure/datasources/http/http_manager.dart';

class AuthResponse implements IAuthResponse {
  @override
  final String token;
  @override
  final User user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

class AuthService implements IAuthRepository {
  final IHttpManager _httpConnectionManager;
  final LocalDatasource _localDatasource;

  AuthService(this._httpConnectionManager, this._localDatasource);

  @override
  Future<Result<AuthResponse>> login(
      {required String email, required String password}) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'auth/login',
      httpMethod: 'POST',
      body: jsonEncode({'email': email, 'password': password}),
      mapperCallBack: (data) {
        return AuthResponse.fromJson(data);
      },
    );
    return result;
  }

  @override
  Future<Result<AuthResponse>> signUp({
    required String email,
    required String fullName,
    required String phoneNumber,
    required String password,
  }) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'auth/signUp',
      httpMethod: 'POST',
      body: jsonEncode({
        'email': email,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'password': password
      }),
      mapperCallBack: (data) {
        return AuthResponse.fromJson(data);
      },
    );
    return result;
  }

  @override
  Future<Result<AuthResponse>> verifyUser() async {
    final token = await _localDatasource.getValue('token');
    if(token == null) {
      return Result.failure(const UnauthorizedException());
    }
    _httpConnectionManager.updateHeaders(
        headerKey: 'Authorization', headerValue: 'Bearer $token');
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'auth/currentUser',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        return AuthResponse.fromJson(data);
      },
    );
    _httpConnectionManager.updateHeaders(
        headerKey: 'Authorization', headerValue: null);
    if (result.isError) {
      await _localDatasource.removeKey('token');
    }
    return result;
  }
}
