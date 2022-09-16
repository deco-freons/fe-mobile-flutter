import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/data/item_filter_model.dart';
import 'package:flutter_boilerplate/page/location_permission.dart';
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
                style: TextStyle(
                    fontSize: CustomFontSize.title,
                    fontWeight: FontWeight.bold),
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
              Navigator.pushNamed(context, LocationPermission.routeName);
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
  List<ItemFilterModel<PrefType>> prefs =
      PrefType.values.map((pref) => ItemFilterModel(data: pref)).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 53.0, left: 21.0, right: 21.0),
          child: Wrap(
            spacing: CustomPadding.md,
            runSpacing: CustomPadding.md,
            alignment: WrapAlignment.center,
            children: [
              for (PrefType pref in PrefType.values)
                PreferenceButton(
                  type: pref,
                  onPressedHandler: () {
                    setState(() {
                      prefs = prefs
                          .map((currPref) => currPref.copyWith(
                              isPicked: currPref.data == pref
                                  ? !currPref.isPicked
                                  : null))
                          .toList();
                    });
                  },
                  isActive: prefs
                      .firstWhere((currPref) => currPref.data == pref)
                      .isPicked,
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
              submit(context, prefs.map((pref) => pref.data.name).toList());
            },
            cornerRadius: 32.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: CustomPadding.sm),
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
