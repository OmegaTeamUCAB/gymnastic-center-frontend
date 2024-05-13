abstract class LocalDatasource {
  Future<void> setKeyValue(String key, String value);
  Future<String?> getValue(String key);
  Future<void> removeKey(String key);
}
