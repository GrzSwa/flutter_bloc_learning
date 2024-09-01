import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageProvider {
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));

  writeData(String key, String value) async {
    try {
      await _flutterSecureStorage.write(key: key, value: value);
      return true;
    } catch (e) {
      print('Failed to save: $e');
      return false;
    }
  }

  readData(String key) async {
    try {
      String data = await _flutterSecureStorage.read(key: key) ?? '';
      return data;
    } catch (e) {
      return null;
    }
  }

  deleteData(String key) async {
    try {
      await _flutterSecureStorage.delete(key: key);
      return true;
    } catch (e) {
      print('Failed to delete: $e');
      return false;
    }
  }
}
