import 'dart:async';
import 'package:flutter_boilerplate/auth/data/auth_data_provider.dart';
import 'package:flutter_boilerplate/auth/data/auth_model.dart';
import 'package:flutter_boilerplate/auth/login/data/login_model.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/auth/data/user_model.dart';
import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/common/service/secure_storage_service.dart';

abstract class AuthRepository implements BaseRepository {
  Future logIn(LoginModel model);
  Future<void> checkAuth();
  Stream<AuthModel> get status async* {}
  void dispose();
}

class AuthRepositoryImpl extends AuthRepository {
  final _controller = StreamController<AuthModel>();
  final AuthDataProvider _authDataProvider = AuthDataProvider();
  final secureStorage = SecureStorageService.getInstance;

  @override
  Stream<AuthModel> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    yield const AuthModel(null, AuthStatus.unknown);
    yield* _controller.stream;
  }

  @override
  Future<void> logIn(LoginModel model) async {
    try {
      final data = await _authDataProvider.login(model);
      Map<String, dynamic> userMap = data["user"];
      String accessToken = data["accessToken"];
      String refreshToken = data["refreshToken"];
      UserModel user = UserModel.fromJson(data["user"]);
      await secureStorage.set(key: "accessToken", value: accessToken);
      await secureStorage.set(key: "refreshToken", value: refreshToken);
      await secureStorage.set(key: "user", value: userMap.toString());
      _controller.add(AuthModel(user, AuthStatus.authenticated));
    } catch (e) {
      _controller.add(const AuthModel(null, AuthStatus.unauthenticated));
      rethrow;
    }
  }

  @override
  Future<void> checkAuth() async {
    await Future.delayed(const Duration(milliseconds: 300), () {
      _controller.add(const AuthModel(null, AuthStatus.unauthenticated));
    });
  }

  @override
  void dispose() => _controller.close();
}
