import 'dart:convert';
import 'package:gymnastic_center/application/services/data-sources/local_data_source.dart';
import 'package:gymnastic_center/core/exception.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/domain/auth/user.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';

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

class PasswordResetResponse implements IPasswordResetResponse {
  @override
  final bool success;

  PasswordResetResponse({required this.success});

  factory PasswordResetResponse.fromJson(Map<String, dynamic> json) {
    return PasswordResetResponse(
      success: json['success'],
    );
  }
}

class AuthRepository implements IAuthRepository {
  final IHttpManager _httpConnectionManager;
  final LocalDataSource _localDataSource;

  AuthRepository(this._httpConnectionManager, this._localDataSource);

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
    final token = result.unwrap().token;
    _httpConnectionManager.updateHeaders(
        headerKey: 'Authorization', headerValue: 'Bearer $token');
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
      urlPath: 'auth/register',
      httpMethod: 'POST',
      body: jsonEncode({
        'email': email,
        'name': fullName,
        'phone': phoneNumber,
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
    final token = await _localDataSource.getValue('token');
    if (token == null) {
      return Result.failure(const UnauthorizedException());
    }
    _httpConnectionManager.updateHeaders(
        headerKey: 'Authorization', headerValue: 'Bearer $token');
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'auth/current',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        return AuthResponse.fromJson(data);
      },
    );
    if (result.isError) {
      await _localDataSource.removeKey('token');
    }
    return result;
  }

  @override
  Future<Result<IPasswordResetResponse>> requestCode(
      {required String email}) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'auth/forget/password',
      httpMethod: 'POST',
      body: jsonEncode({'email': email}),
      mapperCallBack: (data) {
        return PasswordResetResponse.fromJson(data);
      },
    );
    return result;
  }

  @override
  Future<Result<IPasswordResetResponse>> resetPassword(
      {required String email, required String newPassword}) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'auth/change/password',
      httpMethod: 'PUT',
      body: jsonEncode({'email': email, 'password': newPassword}),
      mapperCallBack: (data) {
        return PasswordResetResponse.fromJson(data);
      },
    );
    return result;
  }

  @override
  Future<Result<IPasswordResetResponse>> verifyCode(
      {required String email, required String code}) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'auth/code/validate',
      httpMethod: 'POST',
      body: jsonEncode({'email': email, 'code': code}),
      mapperCallBack: (data) {
        return PasswordResetResponse.fromJson(data);
      },
    );
    return result;
  }

  @override
  logout() async {
    await _localDataSource.removeKey('token');
    _httpConnectionManager.updateHeaders(
        headerKey: 'Authorization', headerValue: null);
  }
}
