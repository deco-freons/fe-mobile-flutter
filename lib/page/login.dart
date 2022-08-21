import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/data/auth_repository.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

import '../auth/login/bloc/login_cubit.dart';
import '../auth/login/bloc/login_state.dart';
import '../auth/login/data/login_model.dart';
import '../common/components/forms/form_component.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginCubit(RepositoryProvider.of<AuthRepository>(context));
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          child: SafeArea(child: buildLogin()),
        ),
      ),
    );
  }

  Widget buildLogin() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 29.0, bottom: 23.0),
          child: Hero(
            tag: "Logo",
            child: Center(
              child: Image.asset(
                'lib/common/assets/images/GlobeIconMedium.png',
                width: 192.0,
                height: 192.0,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 23.0, left: 19.0),
          child: Text(
            'Hello Again!',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BlocConsumer<LoginCubit, LoginState>(
            listener: ((context, state) {}),
            builder: (context, state) {
              return LoginForm();
            }),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final CustomFormInput username =
      CustomFormInput(label: 'Username', type: TextFieldType.string);
  final CustomFormInput password =
      CustomFormInput(label: 'Password', type: TextFieldType.password);

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Sign In',
      inputs: [
        username,
        password,
      ],
      submitTitle: 'Sign In',
      hasForgotPassword: true,
      bottomText: "Don't have an account?",
      textButton: "Register",
      submitHandler: () {
        LoginModel data = LoginModel(
            username: username.controller.text,
            password: password.controller.text);
        submit(context, data);
      },
      textButtonHandler: () {},
    );
  }

  void submit(BuildContext context, LoginModel data) async {
    final cubit = context.read<LoginCubit>();
    await cubit.login(data);
  }
}
