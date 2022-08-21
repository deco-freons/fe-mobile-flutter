import 'dart:async';

import 'package:flutter_boilerplate/auth/data/auth_model.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/auth/data/user_model.dart';

class AuthRepository {
  final _controller = StreamController<AuthModel>();

  Stream<AuthModel> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    yield const AuthModel(null, AuthStatus.unknown);
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300), () {
      UserModel user = const UserModel('1', 'yafi', 'mantap');
      return _controller.add(AuthModel(user, AuthStatus.authenticated));
    });
  }

  Future<void> checkAuth() async {
    await Future.delayed(const Duration(milliseconds: 300), () {
      UserModel user = const UserModel('1', 'yafi', 'mantap');
      return _controller.add(AuthModel(user, AuthStatus.unauthenticated));
    });
  }

  void dispose() => _controller.close();
}
