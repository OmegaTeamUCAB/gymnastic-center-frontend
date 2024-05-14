import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gymnastic_center/application/services/datasources/local_datasource.dart';

class SecureStorage implements LocalDatasource {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Future<String?> getValue(String key) async {
    try {
      final value = await storage.read(key: key);
      return value;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setKeyValue(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  @override
  Future<void> removeKey(String key) async {
    await storage.delete(key: key);
  }
}
