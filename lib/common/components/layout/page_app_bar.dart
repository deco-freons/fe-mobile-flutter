import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/circle_icon_button.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasBackButton;
  final String title;
  final Widget? widget;
  const PageAppBar(
      {Key? key, this.hasBackButton = false, required this.title, this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: appBarHeight,
      backgroundColor: neutral.shade100,
      titleSpacing: 0,
      leading: hasBackButton
          ? Padding(
              padding: const EdgeInsets.only(left: CustomPadding.body),
              child: CircleIconButton(
                icon:
                    Icon(Icons.arrow_back, color: neutral.shade900, size: 35.0),
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
