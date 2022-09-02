import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/page/popular_events.dart';

class HomeContent extends StatefulWidget {
  final String title;
  final List<Widget> contentWidgets;
  final bool isSeeAll;
  final double contentSpacing;
  final double titleBottomSpacing;
  final double titleLeftSpacing;

  const HomeContent({
    Key? key,
    required this.title,
    required this.contentWidgets,
    this.isSeeAll = false,
    this.contentSpacing = CustomPadding.md,
    this.titleBottomSpacing = CustomPadding.md,
    this.titleLeftSpacing = CustomPadding.body,
  }) : super(key: key);

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
                left: widget.titleLeftSpacing),
            child: (widget.isSeeAll)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: CustomFontSize.lg,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: widget.titleLeftSpacing),
                        child: CustomTextButton(
                            text: 'See All >',
                            fontSize: CustomFontSize.sm,
                            type: TextButtonType.tertiary,
                            onPressedHandler: () {
                              Navigator.pushNamed(
                                  context, PopularEvents.routeName);
                            }),
                      )
                    ],
                  )
                : Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: CustomFontSize.lg,
                        fontWeight: FontWeight.bold),
                  )),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: widget.contentSpacing,
            children: widget.contentWidgets
                .asMap()
                .map((i, element) => MapEntry(
                    i,
                    Padding(
                      padding: i == 0
                          ? const EdgeInsets.only(left: CustomPadding.body)
                          : i == widget.contentWidgets.length - 1
                              ? const EdgeInsets.only(right: CustomPadding.body)
                              : EdgeInsets.zero,
                      child: element,
                    )))
                .values
                .toList(),
          ),
        ),
      ],
    );
  }
}
