import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/register/bloc/register_cubit.dart';
import 'package:flutter_boilerplate/auth/register/data/register_model.dart';
import 'package:flutter_boilerplate/auth/register/data/register_repository.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/form_component.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/regex.dart';
import 'package:flutter_boilerplate/page/email_confirmation.dart';
import 'package:flutter_boilerplate/page/login.dart';
import '../auth/register/bloc/register_state.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final RegisterRepositoryImpl registerRepository = RegisterRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(registerRepository),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          child: SafeArea(child: buildRegister()),
        ),
      ),
    );
  }

  Widget buildRegister() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 29.0, bottom: 45.0),
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
        BlocConsumer<RegisterCubit, RegisterState>(
          builder: (context, state) {
            if (state is RegisterLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            } else if (state is RegisterErrorState) {
              return RegisterForm(errorMessage: state.errorMessage);
            } else {
              return RegisterForm();
            }
          },
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              Navigator.pushNamed(context, EmailConfirmation.routeName);
            }
          },
        ),
      ],
    );
  }
}

class RegisterForm extends StatelessWidget {
  final String errorMessage;

  RegisterForm({Key? key, this.errorMessage = ""}) : super(key: key);

  final CustomFormInput firstName =
      CustomFormInput(label: 'First Name', type: TextFieldType.string);
  final CustomFormInput lastName =
      CustomFormInput(label: 'Last Name', type: TextFieldType.string);
  final CustomFormInput username = CustomFormInput(
      label: 'Username',
      type: TextFieldType.string,
      pattern: usernamePattern,
      errorMessage: "error");
  final CustomFormInput email = CustomFormInput(
      label: 'Email', type: TextFieldType.string, errorMessage: "error");
  final CustomFormInput birthDate = CustomFormInput(
      label: 'Birth Date',
      type: TextFieldType.date,
      firstDate: DateTime(1900),
      lastDate: DateTime.now());
  final CustomFormInput password = CustomFormInput(
      label: 'Password',
      type: TextFieldType.password,
      pattern: passwordPattern,
      errorMessage: "Password must be 8-20 character (including number)",
      confirmField: true);

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Sign Up',
      inputs: [
        firstName,
        lastName,
        username,
        email,
        birthDate,
        password,
      ],
      submitTitle: 'Create Account',
      bottomText: 'Already have an account?',
      textButton: "Sign In",
      submitHandler: () {
        RegisterModel data = RegisterModel(
            username: username.controller.text,
            firstName: firstName.controller.text,
            lastName: lastName.controller.text,
            email: email.controller.text,
            password: password.controller.text,
            confirmPassword: password.confirmController.text,
            birthDate: birthDate.controller.text);
        submit(context, data);
      },
      textButtonHandler: () {
        Navigator.pushNamed(context, Login.routeName);
      },
      errorMessage: errorMessage,
    );
  }

  void submit(BuildContext context, RegisterModel data) {
    final cubit = context.read<RegisterCubit>();
    cubit.register(data);
  }
}
