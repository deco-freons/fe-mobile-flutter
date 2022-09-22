import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/circle_icon_button.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasLeadingWidget;
  final Widget? leadingWidget;
  final String title;
  final Widget? widget;
  final double? leadingWidth;

  final bool hasDivider;
  const PageAppBar(
      {Key? key,
      this.hasLeadingWidget = false,
      required this.title,
      this.widget,
      this.leadingWidget,
      this.leadingWidth,
      this.hasDivider = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: appBarHeight,
      backgroundColor: neutral.shade100,
      titleSpacing: 0,
      leadingWidth: leadingWidth,
      leading: hasLeadingWidget
          ? leadingWidget ??
              Padding(
                padding: const EdgeInsets.only(left: CustomPadding.body),
                child: CircleIconButton(
                  icon: Icon(Icons.arrow_back,
                      color: neutral.shade900, size: 35.0),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
          : null,
      bottom: hasDivider
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1.5),
              child: Container(
                height: 1,
                color: neutral.shade400,
              ),
            )
          : null,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: CustomFontSize.title,
          fontWeight: FontWeight.bold,
          color: neutral.shade900,
        ),
      ),
      actions: widget != null ? [widget!] : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}
