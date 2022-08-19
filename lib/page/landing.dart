import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/example/bloc/example_cubit.dart';
import 'package:flutter_boilerplate/example/bloc/example_state.dart';
import 'package:flutter_boilerplate/example/data/example_repository.dart';
import 'package:flutter_boilerplate/page/page.dart';
import 'package:flutter_boilerplate/page/register.dart';

import '../common/components/buttons/custom_button.dart';
import '../common/components/buttons/custom_text_button.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);
  static const routeName = '/landing';

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
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
          child: SafeArea(child: buildLanding()),
        ),
      ),
    );
  }

  Widget buildLanding() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 87.0),
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
                      const EdgeInsets.only(top: 51.0, left: 40.0, right: 40.0),
                  child: Text(
                    'Create, Find, and Join event around you!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 55.0, right: 55.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet. Qui voluptatibus officiis et quibusdam',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 56.0, right: 26.0, left: 26.0),
                  child: CustomButton(
                    label: 'Create account',
                    type: 'secondary',
                    cornerRadius: 32.0,
                    onPressedHandler: () {
                      Navigator.pushNamed(context, Register.routeName);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 26.0, bottom: 54.0),
                  child: CustomTextButton(
                    text: 'Sign in',
                    type: 'secondary',
                    fontSize: 20.0,
                    onPressedHandler: () {
                      Navigator.pushNamed(context, Pages.routeName);
                    },
                  ),
                )
              ],
            );
          }
        }),
      ],
    );
  }
}
