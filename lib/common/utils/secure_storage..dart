// ignore_for_file: file_names

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage flutterSecureStorage;

  SecureStorage(this.flutterSecureStorage);

  Future<void> set({required String key, required String value}) async {
    await flutterSecureStorage.write(key: key, value: value);
  }

  Future<String?> get({required String key}) async {
    return flutterSecureStorage.read(key: key);
  }

  Future<void> clear({required String key}) async {
    return flutterSecureStorage.delete(key: key);
  }
}
