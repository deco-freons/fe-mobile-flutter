import 'dart:async';
import 'package:flutter_boilerplate/auth/data/auth_data_provider.dart';
import 'package:flutter_boilerplate/auth/data/auth_model.dart';
import 'package:flutter_boilerplate/auth/login/data/login_model.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/auth/data/user_model.dart';
import 'package:flutter_boilerplate/common/data/base_repository.dart';

import 'package:flutter_boilerplate/common/utils/error_handler.dart';

abstract class AuthRepository implements BaseRepository {
  Future<void> logIn(LoginModel model);
  Future<void> checkAuth();
  Stream<AuthModel> get status async* {}
  void dispose();
}

class AuthRepositoryImpl extends AuthRepository {
  final _controller = StreamController<AuthModel>();
  final AuthDataProvider _authDataProvider = AuthDataProvider();

  @override
  Stream<AuthModel> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    yield const AuthModel(null, AuthStatus.unknown);
    yield* _controller.stream;
  }

  @override
  Future logIn(LoginModel model) async {
    try {
      final data = await _authDataProvider.login(model);
      UserModel user = UserModel.fromJson(data['user']);
      _controller.add(AuthModel(user, AuthStatus.authenticated));
    } catch (e) {
      _controller.add(const AuthModel(null, AuthStatus.unauthenticated));
      return ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> checkAuth() async {
    await Future.delayed(const Duration(milliseconds: 300), () {
      UserModel user = const UserModel(
          id: "1",
          firstName: "Yafi",
          lastName: "Ahsan",
          email: "RafadanaM@gmail.com",
          birthDate: "2022-06-06",
          username: "RafadanaM");
      _controller.add(AuthModel(user, AuthStatus.unauthenticated));
    });
  }

  @override
  void dispose() => _controller.close();
}
