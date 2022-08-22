import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth/forget/bloc/forget_state.dart';
import '../auth/forget/data/forget_repository.dart';
import '../common/components/forms/custom_form_input_class.dart';
import '../common/config/enum.dart';
import '../auth/forget/bloc/forget_cubit.dart';
import '../auth/forget/data/forget_model.dart';
import '../common/components/forms/form_component.dart';
import 'register.dart';

class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);
  static const routeName = '/forget';

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetCubit(ForgetRepositoryImpl()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          child: SafeArea(child: buildForget()),
        ),
      ),
    );
  }

  Widget buildForget() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 29.0, bottom: 45.0),
          child: Center(
              child:
                  Image.asset('lib/common/assets/images/GlobeIconSmall.png')),
        ),
        BlocBuilder<ForgetCubit, ForgetState>(builder: (context, state) {
          if (state is ForgetSuccessState) {
            return const Text("success");
          } else if (state is ForgetLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          } else if (state is ForgetErrorState) {
            return ForgetForm(errorMessage: state.error.message);
          } else {
            return ForgetForm();
          }
        }),
      ],
    );
  }
}

class ForgetForm extends StatelessWidget {
  final String errorMessage;

  ForgetForm({Key? key, this.errorMessage = ''}) : super(key: key);

  final CustomFormInput email =
      CustomFormInput(label: 'Email', type: TextFieldType.string);

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Forgot password',
      inputs: [email],
      submitTitle: 'Submit',
      textButton: "Back to sign in",
      submitPadding: 35.0,
      textButtonPadding: 35.0,
      bottomPadding: 194.0,
      submitHandler: () {
        ForgetModel data = ForgetModel(
          email: email.controller.text,
        );
        submit(context, data);
      },
      textButtonHandler: () {
        Navigator.pushNamed(context, Register.routeName);
      },
      errorMessage: errorMessage,
    );
  }

  void submit(BuildContext context, ForgetModel data) {
    final cubit = context.read<ForgetCubit>();
    cubit.forget(data);
  }
}
