import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/bloc/register/register_cubit.dart';
import 'package:flutter_boilerplate/auth/bloc/register/register_state.dart';
import 'package:flutter_boilerplate/auth/data/register/register_model.dart';
import 'package:flutter_boilerplate/auth/data/register/register_repository.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_component.dart';
import 'package:flutter_boilerplate/common/components/layout/logo.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/regex.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/page/auth/email_confirmation.dart';
import 'package:flutter_boilerplate/page/auth/login.dart';

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
          padding: const EdgeInsets.only(top: CustomPadding.xxl, bottom: 45.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Logo(height: 80),
              SizedBox(width: 10),
              Logo.slogan(height: 80),
            ],
          ),
        ),
        BlocConsumer<RegisterCubit, RegisterState>(
          builder: (context, state) {
            if (state is RegisterLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
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

  final CustomFormInput firstName = CustomFormInput(
    label: 'First Name',
    type: TextFieldType.string,
    required: true,
  );
  final CustomFormInput lastName = CustomFormInput(
    label: 'Last Name',
    type: TextFieldType.string,
    required: true,
  );
  final CustomFormInput username = CustomFormInput(
      label: 'Username',
      type: TextFieldType.string,
      pattern: usernamePattern,
      required: true,
      errorMessage: "error");
  final CustomFormInput email = CustomFormInput(
      label: 'Email',
      type: TextFieldType.string,
      required: true,
      errorMessage: "error");
  final CustomFormInput birthDate = CustomFormInput(
      label: 'Birth Date',
      type: TextFieldType.date,
      firstDate: DateTime(1900),
      lastDate: DateTime.now());
  final CustomFormInput location = CustomFormInput(
    label: 'Location',
    type: TextFieldType.suburbDropdown,
  );
  final CustomFormInput password = CustomFormInput(
      label: 'Password',
      type: TextFieldType.password,
      pattern: passwordPattern,
      required: true,
      errorMessage: "Password must be 8-20 character (including number)",
      confirmField: true);
  final CustomFormInput showLocationPermission = CustomFormInput(
    label:
        'If you agree to share location with other users, please tick this box.',
    type: TextFieldType.checkbox,
  );

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
        location,
        password,
        showLocationPermission
      ],
      submitTitle: 'Create Account',
      bottomText: 'Already have an account?',
      textButton: "Sign In",
      textButtonType: TextButtonType.primary,
      submitHandler: () {
        RegisterModel data = RegisterModel(
          username: username.controller.text,
          firstName: firstName.controller.text,
          lastName: lastName.controller.text,
          email: email.controller.text,
          password: password.controller.text,
          confirmPassword: password.confirmController.text,
          birthDate: birthDate.controller.text,
          location: location.controller.text == ""
              ? 0
              : int.parse(location.controller.text),
          isShareLocation: showLocationPermission.checkbox,
        );
        submit(context, data);
      },
      textButtonHandler: () {
        Navigator.pushReplacementNamed(context, Login.routeName);
      },
      errorMessage: errorMessage,
    );
  }

  void submit(BuildContext context, RegisterModel data) {
    final cubit = context.read<RegisterCubit>();
    cubit.register(data);
  }
}
