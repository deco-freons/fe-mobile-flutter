import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/custom_text_button.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/page/popular_events.dart';

class HomeContent extends StatefulWidget {
  final String title;
  final List<Widget> contentWidgets;
  final double contentPadding;
  final double titlePadding;
  final bool isPopular;

  const HomeContent({
    Key? key,
    required this.title,
    required this.contentWidgets,
    this.contentPadding = 0.0,
    this.titlePadding = 22.0,
    this.isPopular = false,
  }) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.only(
                left: 30.0, bottom: widget.titlePadding, right: 15.0),
            child: (widget.isPopular)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      CustomTextButton(
                          text: 'See All >',
                          fontSize: 14.0,
                          type: TextButtonType.tertiary,
                          onPressedHandler: () {
                            Navigator.pushNamed(
                                context, PopularEvents.routeName);
                          })
                    ],
                  )
                : Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  )),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: widget.contentPadding),
            child: Row(
              children: widget.contentWidgets,
            ),
          ),
        ),
      ]),
    );
  }
}
