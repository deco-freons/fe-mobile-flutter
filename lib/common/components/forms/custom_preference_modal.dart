import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_button.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/data/item_filter_model.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';

class CustomPreferenceModal extends StatefulWidget {
  final List<String> initialPrefs;

  CustomPreferenceModal({Key? key, List<String>? initialPrefs})
      : initialPrefs = initialPrefs ?? [],
        super(key: key);

  @override
  State<CustomPreferenceModal> createState() => _CustomPreferenceModalState();
}

class _CustomPreferenceModalState extends State<CustomPreferenceModal> {
  List<ItemFilterModel<PrefType>> prefs =
      PrefType.values.map((pref) => ItemFilterModel(data: pref)).toList();

  @override
  void initState() {
    super.initState();

    setState(() {
      prefs = prefs
          .map((pref) => widget.initialPrefs.contains(pref.data.name)
              ? pref.copyWith(isPicked: true)
              : pref)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      padding: const EdgeInsets.symmetric(horizontal: CustomPadding.lg),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(CustomRadius.body),
            topRight: Radius.circular(CustomRadius.body)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            spacing: CustomPadding.sm,
            runSpacing: 0.0,
            alignment: WrapAlignment.center,
            children: [
              for (var pref in PrefType.values)
                PreferenceButton(
                  type: pref,
                  onPressedHandler: () {
                    setState(() {
                      prefs = prefs
                          .map((currPref) => currPref.data == pref
                              ? currPref.copyWith(isPicked: !currPref.isPicked)
                              : currPref)
                          .toList();
                    });
                  },
                  isActive: prefs
                      .firstWhere((currPref) => currPref.data == pref)
                      .isPicked,
                ),
            ],
          ),
          const SizedBox(height: 53.0),
          CustomButton(
              label: "Add",
              type: ButtonType.primary,
              cornerRadius: CustomRadius.button,
              onPressedHandler: () {
                Navigator.pop(
                    context,
                    prefs
                        .where((pref) => pref.isPicked)
                        .map((pref) => pref.data)
                        .toList());
              }),
          const SizedBox(height: 20.0),
          CustomTextButton(
              text: "Cancel",
              type: TextButtonType.error,
              onPressedHandler: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
