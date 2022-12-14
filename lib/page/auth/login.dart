import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/bloc/login/login_cubit.dart';
import 'package:flutter_boilerplate/auth/bloc/login/login_state.dart';
import 'package:flutter_boilerplate/auth/data/auth/auth_repository.dart';
import 'package:flutter_boilerplate/auth/data/login/login_model.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_component.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/layout/logo.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/page/auth/register.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 110),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Logo(height: 80),
              SizedBox(width: 10),
              Logo.slogan(height: 80),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              bottom: CustomPadding.md, left: CustomPadding.body),
          child: Text(
            'Hello Again!',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: CustomFontSize.xxl,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            }
            if (state is LoginErrorState) {
              return LoginForm(
                errorMessage: state.errorMessage,
              );
            } else {
              return LoginForm();
            }
          },
        ),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  final String errorMessage;
  LoginForm({Key? key, this.errorMessage = ""}) : super(key: key);

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
      textButtonType: TextButtonType.primary,
      submitHandler: () {
        LoginModel data = LoginModel(
            username: username.controller.text,
            password: password.controller.text);
        submit(context, data);
      },
      textButtonHandler: () {
        Navigator.pushReplacementNamed(context, Register.routeName);
      },
      errorMessage: errorMessage,
    );
  }

  void submit(BuildContext context, LoginModel data) async {
    final cubit = context.read<LoginCubit>();
    await cubit.login(data);
  }
}
