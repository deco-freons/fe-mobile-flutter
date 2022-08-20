import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/example/bloc/example_cubit.dart';
import 'package:flutter_boilerplate/example/bloc/example_state.dart';
import 'package:flutter_boilerplate/example/data/example_model.dart';
import 'package:flutter_boilerplate/example/data/example_repository.dart';

import '../common/components/buttons/custom_button.dart';
import '../common/components/buttons/custom_text_button.dart';
import '../common/components/buttons/preference_button.dart';

class Preference extends StatefulWidget {
  const Preference({Key? key}) : super(key: key);
  static const routeName = '/preference';

  @override
  _PreferenceState createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExampleCubit(ExampleRepositoryImpl()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: SafeArea(child: buildPreference()),
        ),
      ),
    );
  }

  Widget buildPreference() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 61.0, left: 22.0, right: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 50.0),
                child: BackButton(),
              ),
              Text(
                'Select Interest',
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
            ],
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
            return PreferenceForm();
          }
        }),
      ],
    );
  }
}

class PreferenceForm extends StatefulWidget {
  PreferenceForm({Key? key}) : super(key: key);

  @override
  State<PreferenceForm> createState() => _PreferenceFormState();
}

class _PreferenceFormState extends State<PreferenceForm> {
  List<bool> clickCheck = List.filled(PrefButtonType.values.length, true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 53.0, left: 21.0, right: 21.0),
          child: Wrap(
            spacing: 16.0,
            runSpacing: 15.0,
            alignment: WrapAlignment.center,
            children: [
              for (var pref in PrefButtonType.values)
                PreferenceButton(
                  type: pref,
                  onPressedHandler: () {
                    setState(() {
                      clickCheck[pref.index] = !clickCheck[pref.index];
                    });
                  },
                  click: clickCheck[pref.index],
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 327.0, left: 22.0, right: 22.0),
          child: CustomButton(
            label: 'Done',
            type: ButtonType.primary,
            onPressedHandler: () {
              ExampleModel data = ExampleModel(message: "preference");
              submit(context, data);
            },
            cornerRadius: 32.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: CustomTextButton(
              text: 'Skip',
              type: TextButtonType.tertiary,
              onPressedHandler: () {}),
        )
      ],
    );
  }

  void submit(BuildContext context, ExampleModel data) {
    final cubit = context.read<ExampleCubit>();
    cubit.healthcheck();
  }
}
