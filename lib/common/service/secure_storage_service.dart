import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  late FlutterSecureStorage flutterSecureStorage;

  SecureStorageService._internal() {
    flutterSecureStorage = const FlutterSecureStorage();
  }

  static SecureStorageService get getInstance => _instance;

  Future<void> set({required String key, required String value}) async {
    await flutterSecureStorage.write(key: key, value: value);
  }

  Future<String?> get({required String key}) async {
    return flutterSecureStorage.read(key: key);
  }
}
