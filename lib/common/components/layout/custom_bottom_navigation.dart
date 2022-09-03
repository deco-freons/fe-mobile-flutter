import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final List<Icon> children;
  final void Function(int) onTap;
  const CustomBottomNavigation(
      {Key? key,
      required this.currentIndex,
      required this.children,
      required this.onTap})
      : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(blurRadius: 5.0, offset: Offset(0.0, 2.0))
        ],
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildChildren()),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = widget.children
        .asMap()
        .map((key, icon) => MapEntry(
              key,
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: widget.currentIndex == key
                        ? const [
                            BoxShadow(
                              color: primary,
                              spreadRadius: -0.5,
                              offset: Offset(0, -1.75),
                            ),
                            BoxShadow(
                              color: primary,
                              spreadRadius: -7,
                              blurRadius: 5,
                              offset: Offset(0, -9),
                            )
                          ]
                        : null,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: IconButton(
                    splashColor: primary,
                    highlightColor: primary,
                    iconSize: 40,
                    color: widget.currentIndex == key ? primary : neutral,
                    onPressed: () {
                      widget.onTap(key);
                    },
                    icon: icon,
                  ),
                ),
              ),
            ))
        .values
        .toList();
    children.insert(widget.children.length >> 1, _buildMiddleItem());
    return children;
  }

  Widget _buildMiddleItem() => Expanded(
        child: Container(
          color: Theme.of(context).backgroundColor,
        ),
      );
}
