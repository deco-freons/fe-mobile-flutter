import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final bool isLoading;
  const ProfileField(
      {Key? key,
      required this.label,
      required this.value,
      this.isLoading = false})
      : super(key: key);

  const ProfileField.loading(
      {Key? key, this.label = "", this.value = "", this.isLoading = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 38.0),
        !isLoading
            ? Text(
                label,
                style: TextStyle(
                  fontSize: CustomFontSize.base,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              )
            : BuildLoading.buildRectangularLoading(height: 16, width: 75),
        !isLoading
            ? Text(
                value,
                style: TextStyle(
                  fontSize: CustomFontSize.lg,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: CustomPadding.sm),
                child: BuildLoading.buildRectangularLoading(
                    height: 20, width: 150),
              ),
      ],
    );
  }
}
