import 'dart:convert';
import 'dart:io';
import 'package:gymnastic_center/application/models/user.dart';
import 'package:gymnastic_center/domain/auth/repository/auth_repository.dart';
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

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
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
        User newUser = jsonDecode(response.body);
        return newUser;
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
}
