import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class HomeContent extends StatefulWidget {
  final String title;
  final List<Widget> contentWidgets;
  final bool isPair;
  final double contentSpacing;
  final double titleBottomSpacing;
  final double titleLeftSpacing;
  final double titleRightSpacing;
  final Widget secondWidget;
  final bool isCentered;

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
      this.isCentered = false})
      : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(
                bottom: widget.titleBottomSpacing,
                left: widget.titleLeftSpacing,
                right: widget.titleRightSpacing),
            child: (widget.isPair)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: CustomFontSize.lg,
                            fontWeight: FontWeight.bold),
                      ),
                      widget.secondWidget,
                    ],
                  )
                : Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: CustomFontSize.lg,
                        fontWeight: FontWeight.bold),
                  )),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: widget.contentSpacing,
              children: widget.contentWidgets
                  .asMap()
                  .map((i, element) => MapEntry(
                      i,
                      Padding(
                        padding: i == 0
                            ? EdgeInsets.only(
                                left:
                                    widget.isCentered ? 0 : CustomPadding.body)
                            : i == widget.contentWidgets.length - 1
                                ? const EdgeInsets.only(
                                    right: CustomPadding.body)
                                : EdgeInsets.zero,
                        child: element,
                      )))
                  .values
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
