import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/auth/data/auth/auth_repository.dart';
import 'package:flutter_boilerplate/common/utils/secure_storage..dart';
import 'package:flutter_boilerplate/get_it.dart';

class Refresh extends QueuedInterceptor {
  final SecureStorage _secureStorage = getIt.get<SecureStorage>();

  final Dio refreshDio =
      Dio(BaseOptions(baseUrl: "https://deco-freons-be.devs.id"));

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return super.onError(err, handler);
    }
    // Handle 401
    try {
      RequestOptions? origin = err.response?.requestOptions;
      if (origin == null) {
        getIt.get<AuthRepository>().forceLogout();
        return super.onError(err, handler);
      }
      String? oldRefreshToken = await _secureStorage.get(key: "refreshToken");
      Response<dynamic> res = await refreshDio
          .post("/auth/refresh-token", data: {"refreshToken": oldRefreshToken});
      String accessToken = res.data["accessToken"];
      String refreshToken = res.data["refreshToken"];
      await _secureStorage.set(key: "accessToken", value: accessToken);
      await _secureStorage.set(key: "refreshToken", value: refreshToken);
      origin.headers["Authorization"] = accessToken;
      final response = await refreshDio.fetch(origin);
      handler.resolve(response);
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          getIt.get<AuthRepository>().forceLogout();
        }
      }

      return super.onError(err, handler);
    }
  }
}
