import 'dart:convert';
import 'dart:io';
import 'package:gymnastic_center/application/models/user.dart';
import 'package:gymnastic_center/domain/auth/repository/auth_repository.dart';
import 'package:gymnastic_center/infrastructure/config/local-storage/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService implements IAuthRepository {
  @override
  Future<User> login(Map<String, dynamic> loginCredentials) async {
    final url = Uri.parse('${dotenv.env['API_URL']}/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(loginCredentials),
      );

      //todo: change to 200 when backend is fixed
      if (response.statusCode == 201) {
        final loginData = jsonDecode(response.body);
        SecureStorage().writeSecureData('token', loginData.token);
        return loginData.user;
      } else {
        throw Exception(
            'Login failed with status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Network error occurred.');
    } on FormatException {
      throw Exception('Invalid response format.');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> signUp(Map<String, dynamic> signUpCredentials) async {
    final url = Uri.parse('${dotenv.env['API_URL']}/auth/signUp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(signUpCredentials),
      );

      if (response.statusCode == 201) {
        final signUpData = jsonDecode(response.body);
        SecureStorage().writeSecureData('token', signUpData.token);
        return signUpData.user;
      } else {
        throw Exception(
            'Sign-up failed with status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Network error occurred.');
    } on FormatException {
      throw Exception('Invalid response format.');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> verifyUser() async {
    final url = Uri.parse('${dotenv.env['API_URL']}/auth/currentUser');

    try {
      final token = SecureStorage().readSecureData('token');
      if (token == null) throw Exception('No token in session');
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        SecureStorage().writeSecureData('token', userData.token);
        return userData.user;
      } else {
        throw Exception(
            'Verify user failed with status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Network error occurred.');
    } catch (e) {
      rethrow;
    }
  }
}
