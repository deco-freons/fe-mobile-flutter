import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/auth/bloc/register/register_cubit.dart';
import 'package:flutter_boilerplate/auth/bloc/register/register_state.dart';
import 'package:flutter_boilerplate/auth/data/register/register_model.dart';
import 'package:flutter_boilerplate/auth/data/register/register_repository.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/form_component.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/regex.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(RegisterRepositoryImpl()),
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
          child: Center(
              child:
                  Image.asset('lib/common/assets/images/GlobeIconSmall.png')),
        ),
        BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
          if (state is RegisterSuccessState) {
            return const Text("success");
          } else if (state is RegisterLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          } else if (state is RegisterErrorState) {
            return RegisterForm(errorMessage: state.error.message);
          } else {
            return RegisterForm();
          }
        }),
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
      errorMessage: "Password must be 8-20 character (including number)");
  late final CustomFormInput confirmPassword = CustomFormInput(
      label: 'Confirm Password',
      type: TextFieldType.password,
      pattern: password.controller.text,
      errorMessage: "Must be the same as Password");

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
        confirmPassword,
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
            confirmPassword: confirmPassword.controller.text,
            birthDate: birthDate.controller.text);
        submit(context, data);
      },
      textButtonHandler: () {},
      errorMessage: errorMessage,
    );
  }

  void submit(BuildContext context, RegisterModel data) {
    final cubit = context.read<RegisterCubit>();
    cubit.register(data);
  }
}
