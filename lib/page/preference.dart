import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/page/dashboard.dart';
import 'package:flutter_boilerplate/preference/data/preference_repository.dart';
import '../../common/config/enum.dart';
import '../preference/bloc/preference_cubit.dart';
import '../preference/bloc/preference_state.dart';
import '../common/components/buttons/custom_button.dart';
import '../common/components/buttons/custom_text_button.dart';
import '../preference/components/preference_button.dart';

class Preference extends StatefulWidget {
  const Preference({Key? key}) : super(key: key);
  static const routeName = '/preference';

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreferenceCubit(PreferenceRepositoryImpl()),
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
        BlocConsumer<PreferenceCubit, PreferenceState>(
          builder: (context, state) {
            if (state is PreferenceLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            } else if (state is PreferenceErrorState) {
              return PreferenceForm(errorMessage: state.errorMessage);
            } else {
              return const PreferenceForm();
            }
          },
          listener: (context, state) {
            if (state is PreferenceSuccessState) {
              Navigator.pushNamed(context, Dashboard.routeName);
            }
          },
        ),
      ],
    );
  }
}

class PreferenceForm extends StatefulWidget {
  final String errorMessage;

  const PreferenceForm({Key? key, this.errorMessage = ''}) : super(key: key);

  @override
  State<PreferenceForm> createState() => _PreferenceFormState();
}

class _PreferenceFormState extends State<PreferenceForm> {
  List<bool> clickCheck = List.filled(PrefType.values.length, true);
  List<String> preferenceList = [];

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
              for (var pref in PrefType.values)
                PreferenceButton(
                  type: pref,
                  onPressedHandler: () {
                    setState(() {
                      clickCheck[pref.index] = !clickCheck[pref.index];
                    });
                    if (!clickCheck[pref.index]) {
                      preferenceList.add(pref.name);
                    } else {
                      preferenceList.remove(pref.name);
                    }
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
              submit(context, preferenceList);
            },
            cornerRadius: 32.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: CustomTextButton(
              text: 'Skip',
              type: TextButtonType.tertiary,
              onPressedHandler: () {
                skip(context);
              }),
        )
      ],
    );
  }

  void submit(BuildContext context, List<String> data) {
    final cubit = context.read<PreferenceCubit>();
    cubit.setFirstPreference(data);
  }

  void skip(BuildContext context) {
    final cubit = context.read<PreferenceCubit>();
    cubit.skipFirstPreference();
  }
}
