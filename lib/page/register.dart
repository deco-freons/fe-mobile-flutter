import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/form_component.dart';
import 'package:flutter_boilerplate/common/config/regex.dart';
import 'package:flutter_boilerplate/example/bloc/example_cubit.dart';
import 'package:flutter_boilerplate/example/bloc/example_state.dart';
import 'package:flutter_boilerplate/example/data/example_model.dart';
import 'package:flutter_boilerplate/example/data/example_repository.dart';

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
      create: (context) => ExampleCubit(ExampleRepositoryImpl()),
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
        BlocBuilder<ExampleCubit, ExampleState>(builder: (context, state) {
          if (state is ExampleSuccessState) {
            return const Text("success");
          } else if (state is ExampleLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          } else {
            return RegisterForm();
          }
        }),
      ],
    );
  }
}

class RegisterForm extends StatelessWidget {
  RegisterForm({Key? key}) : super(key: key);

  final CustomFormInput firstName =
      CustomFormInput(label: 'First Name', type: "string");
  final CustomFormInput lastName =
      CustomFormInput(label: 'Last Name', type: "string");
  final CustomFormInput email =
      CustomFormInput(label: 'Email', type: "string", errorMessage: "error");
  final CustomFormInput password = CustomFormInput(
      label: 'Password',
      type: "password",
      pattern: passwordPattern,
      errorMessage: "Password must be 8-20 character (including number)");
  final CustomFormInput date = CustomFormInput(
      label: 'Birth Date',
      type: "date",
      firstDate: DateTime(1900),
      lastDate: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Sign Up',
      inputs: [firstName, lastName, email, password, date],
      submitTitle: 'Create Account',
      bottomText: 'Already have an account?',
      textButton: "Sign In",
      submitHandler: () {
        ExampleModel data = ExampleModel(message: 'fullName');
        submit(context, data);
      },
    );
  }

  void submit(BuildContext context, ExampleModel data) {
    final cubit = context.read<ExampleCubit>();
    cubit.healthcheck();
  }
}
