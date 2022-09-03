import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/shimmer_widget.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class PreferenceButton extends StatelessWidget {
  final PrefType type;
  final VoidCallback? onPressedHandler;
  final double cornerRadius;
  final bool click;
  final String stringInput;
  final bool useStringInput;
  final bool cancelIcon;
  final double elevation;
  final double clickedElevation;
  final bool isAll;
  final bool isLoading;

  const PreferenceButton(
      {Key? key,
      this.type = PrefType.MV,
      this.onPressedHandler,
      this.cornerRadius = 50.0,
      this.click = true,
      this.stringInput = "",
      this.useStringInput = false,
      this.cancelIcon = false,
      this.elevation = 0.0,
      this.clickedElevation = 0.0,
      this.isAll = false,
      this.isLoading = false})
      : super(key: key);

  const PreferenceButton.loading(
      {Key? key,
      this.type = PrefType.MV,
      this.onPressedHandler,
      this.cornerRadius = 50.0,
      this.click = true,
      this.stringInput = "",
      this.useStringInput = false,
      this.cancelIcon = false,
      this.elevation = 0.0,
      this.clickedElevation = 0.0,
      this.isAll = false,
      this.isLoading = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    );

    BorderRadius borderRadius = BorderRadius.all(Radius.circular(cornerRadius));

    return onPressedHandler != null
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: (click) ? elevation : clickedElevation,
                side: BorderSide(width: 1.0, color: primary.shade400),
                primary: (click)
                    ? primary.shade300
                    : Theme.of(context).colorScheme.primary,
                onPrimary: (click)
                    ? neutral.shade800
                    : Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                )),
            onPressed: onPressedHandler,
            child: IntrinsicWidth(
              child: Row(
                children: [
                  Text(
                      useStringInput
                          ? stringInput
                          : isAll
                              ? 'All'
                              : type.desc,
                      style: textStyle),
                  cancelIcon
                      ? Icon(
                          Icons.close_rounded,
                          color: neutral.shade500,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          )
        : !isLoading
            ? Container(
                margin: const EdgeInsets.only(top: 6.5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.5, vertical: 5),
                decoration: BoxDecoration(
                  color: primary.shade300,
                  border: Border.all(color: primary.shade400),
                  borderRadius: borderRadius,
                ),
                child: IntrinsicWidth(
                  child: Row(
                    children: [
                      Text(stringInput, style: textStyle),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 6.5),
                child: ShimmerWidget.rectangular(
                  height: 30,
                  width: 75,
                  shapeBorder:
                      RoundedRectangleBorder(borderRadius: borderRadius),
                ),
              );
  }
}
