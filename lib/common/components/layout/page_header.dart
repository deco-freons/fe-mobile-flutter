import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class PageHeader extends StatelessWidget {
  final String title;
  const PageHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: bodyPadding,
      child: SizedBox(
        height: appBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.error),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: CustomFontSize.title, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
