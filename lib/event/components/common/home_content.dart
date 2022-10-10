import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class HomeContent extends StatelessWidget {
  final String title;
  final List<Widget> contentWidgets;
  final bool isPair;
  final double contentSpacing;
  final double titleBottomSpacing;
  final double titleLeftSpacing;
  final double titleRightSpacing;
  final Widget secondWidget;
  final bool isCentered;
  final bool onlyContent;

  const HomeContent(
      {Key? key,
      required this.title,
      required this.contentWidgets,
      this.isPair = false,
      this.contentSpacing = CustomPadding.md,
      this.titleBottomSpacing = CustomPadding.md,
      this.titleLeftSpacing = CustomPadding.body,
      this.titleRightSpacing = CustomPadding.body,
      this.secondWidget = const Text(''),
      this.isCentered = false,
      this.onlyContent = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        !onlyContent
            ? Padding(
                padding: EdgeInsets.only(
                    bottom: titleBottomSpacing,
                    left: titleLeftSpacing,
                    right: titleRightSpacing),
                child: (isPair)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: CustomFontSize.lg,
                                fontWeight: FontWeight.bold),
                          ),
                          secondWidget,
                        ],
                      )
                    : Text(
                        title,
                        style: const TextStyle(
                            fontSize: CustomFontSize.lg,
                            fontWeight: FontWeight.bold),
                      ))
            : const SizedBox.shrink(),
        isCentered
            ? Center(
                child: buildContent(),
              )
            : buildContent(),
      ],
    );
  }

  Widget buildContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: contentSpacing,
        children: contentWidgets
            .asMap()
            .map((i, element) => MapEntry(
                i,
                Padding(
                  padding: i == 0
                      ? EdgeInsets.only(
                          left: isCentered ? 0 : CustomPadding.body)
                      : i == contentWidgets.length - 1
                          ? const EdgeInsets.only(right: CustomPadding.body)
                          : EdgeInsets.zero,
                  child: element,
                )))
            .values
            .toList(),
      ),
    );
  }
}
