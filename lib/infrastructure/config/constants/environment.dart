import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async => await dotenv.load(fileName: ".env");

  static String getApiUrl() =>
      dotenv.env['API_URL'] ?? 'API_URL NO esta configurada';
}
