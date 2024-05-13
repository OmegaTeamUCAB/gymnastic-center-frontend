import 'package:gymnastic_center/application/services/datasources/local_datasource.dart';
import 'package:gymnastic_center/infrastructure/config/local-storage/secure_storage.dart';

class LocalStorage implements LocalDatasource {
  final _secureStorage = SecureStorage();

  @override
  Future<String?> getValue(String key) async {
    try {
      final value = await _secureStorage.readSecureData(key);
      return value;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setKeyValue(String key, String value) async {
    await _secureStorage.writeSecureData(key, value);
  }

  @override
  Future<void> removeKey(String key) async {
    await _secureStorage.deleteSecureData(key);
  }
}
