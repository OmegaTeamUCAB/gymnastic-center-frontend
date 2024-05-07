import 'dart:convert';
import 'package:gymnastic_center/application/models/user.dart';
import 'package:gymnastic_center/domain/auth/repository/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService implements IAuthRepository {
  @override
  Future login(loginCredentials) async {
    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/auth/login'),
        body: loginCredentials);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future signUp(signUpCredentials) async {
    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/auth/signUp'),
        body: signUpCredentials);

    if (response.statusCode == 200) {
      User newUser = jsonDecode(response.body);
      return newUser;
    } else {
      throw Exception(response.body);
    }
  }
}
