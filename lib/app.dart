import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/bloc/auth/auth_bloc.dart';
import 'package:flutter_boilerplate/auth/data/auth/auth_repository.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/navigator_util.dart';
import 'package:flutter_boilerplate/page/landing.dart';
import 'package:flutter_boilerplate/page/get_started.dart';
import 'package:flutter_boilerplate/page/location_permission.dart';
import 'common/config/route_generator.dart';

class App extends StatelessWidget {
  final AuthRepository authRepository;

  const App({Key? key, required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: BlocProvider(
        create: (_) => AuthBloc(authRepository: authRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  NavigatorState get _navigator => NavigatorUtil.navigatorKey.currentState!;

  @override
  void initState() {
    AuthRepository authRepository =
        RepositoryProvider.of<AuthRepository>(context);
    authRepository.checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorUtil.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: CustomTheme.theme,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticatedState) {
              _navigator.pushNamedAndRemoveUntil(
                  LocationPermission.routeName, (route) => false,
                  arguments: false);
            } else if (state is AuthUnauthenticatedState) {
              _navigator.pushNamedAndRemoveUntil(
                  Landing.routeName, (route) => false);
            } else if (state is AuthFirstLoginState) {
              _navigator.pushNamedAndRemoveUntil(
                  GetStarted.routeName, (route) => false);
            }
          },
          child: child,
        );
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
