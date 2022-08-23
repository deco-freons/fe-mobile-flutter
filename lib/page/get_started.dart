import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/example/bloc/example_cubit.dart';
import 'package:flutter_boilerplate/example/bloc/example_state.dart';
import 'package:flutter_boilerplate/example/data/example_repository.dart';
import 'package:flutter_boilerplate/page/preference.dart';

import '../common/components/buttons/custom_button.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);
  static const routeName = '/get_started';

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExampleCubit(ExampleRepositoryImpl()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                0.55,
                1.0
              ],
                  colors: [
                Theme.of(context).colorScheme.primary,
                const Color(0xFF184B5F),
              ])),
          child: SafeArea(child: buildGetStarted()),
        ),
      ),
    );
  }

  Widget buildGetStarted() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 156.0),
          child: Center(
              child:
                  Image.asset('lib/common/assets/images/GlobeIconLarge.png')),
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
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 60.0, right: 26.0, left: 26.0),
                  child: CustomButton(
                    label: 'Get started',
                    type: ButtonType.inverse,
                    cornerRadius: 32.0,
                    onPressedHandler: () {
                      Navigator.pushNamed(context, Preference.routeName);
                    },
                  ),
                ),
              ],
            );
          }
        }),
      ],
    );
  }
}
