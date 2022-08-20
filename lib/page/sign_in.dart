import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/regex.dart';
import 'package:flutter_boilerplate/example/bloc/example_cubit.dart';
import 'package:flutter_boilerplate/example/bloc/example_state.dart';
import 'package:flutter_boilerplate/example/data/example_model.dart';
import 'package:flutter_boilerplate/example/data/example_repository.dart';

import '../common/components/forms/form_component.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const routeName = '/signIn';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExampleCubit(ExampleRepositoryImpl()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          child: SafeArea(child: buildSignIn()),
        ),
      ),
    );
  }

  Widget buildSignIn() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 29.0, bottom: 23.0),
          child: Center(
            child: Image.asset('lib/common/assets/images/GlobeIconSmall.png'),
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
            return SignInForm();
          }
        }),
      ],
    );
  }
}

class SignInForm extends StatelessWidget {
  SignInForm({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Sign In',
      inputs: [
        CustomFormInput(label: 'Email', type: TextFieldType.string),
        CustomFormInput(
          label: 'Password',
          type: TextFieldType.password,
          pattern: passwordPattern,
        )
      ],
      submitTitle: 'Sign In',
      hasForgotPassword: true,
      bottomText: "Don't have an account?",
      textButton: "Register",
      submitHandler: () {
        ExampleModel data = ExampleModel(message: "fullname");
        submit(context, data);
      },
      textButtonHandler: () {},
    );
  }

  void submit(BuildContext context, ExampleModel data) {
    final cubit = context.read<ExampleCubit>();
    cubit.healthcheck();
  }
}
