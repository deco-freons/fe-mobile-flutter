// ignore_for_file: file_names

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  late FlutterSecureStorage flutterSecureStorage;

  SecureStorage._internal() {
    flutterSecureStorage = const FlutterSecureStorage();
  }

  static SecureStorage get getInstance => _instance;

  Future<void> set({required String key, required String value}) async {
    await flutterSecureStorage.write(key: key, value: value);
  }

  Future<String?> get({required String key}) async {
    return flutterSecureStorage.read(key: key);
  }
}
