import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/preference/components/preference_button.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';

class UserInterestChips extends StatelessWidget {
  final List<PreferenceModel>? preferences;
  final bool isLoading;
  const UserInterestChips({Key? key, this.preferences, this.isLoading = false})
      : super(key: key);

  const UserInterestChips.loading(
      {Key? key, this.preferences, this.isLoading = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Interest",
          style: TextStyle(
            fontSize: CustomFontSize.base,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        const SizedBox(
          height: 7.0,
        ),
        Wrap(
          spacing: CustomPadding.sm,
          children: !isLoading
              ? preferences?.map((preference) {
                    return PreferenceButton(
                      stringInput: preference.preferenceName,
                    );
                  }).toList() ??
                  []
              : List.filled(4, const PreferenceButton.loading()),
        ),
      ],
    );
  }
}
