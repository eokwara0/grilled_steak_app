import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Android  options

  SecureStorage(
    FlutterSecureStorage fss,
  ) : fss = fss;

  final FlutterSecureStorage fss;

  Future<String?> readKey(String key) async {
    return fss.read(key: key);
  }

  Future<Map<String, String>> readAll() {
    return fss.readAll();
  }

  Future<void> writeValue(String key, String value) async {
    await fss.write(key: key, value: value);
  }

  Future<void> writeAll(Map<String, String> values) async {
    values.forEach((key, value) {
      fss.write(key: key, value: value);
    });
  }

  Future<void> deleteValue(String key) async {
    await fss.delete(key: key);
  }
}
