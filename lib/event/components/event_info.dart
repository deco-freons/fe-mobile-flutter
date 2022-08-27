import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';

class EventInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final bool loading;
  final VoidCallback? onTap;
  const EventInfo(
      {Key? key,
      required this.icon,
      required this.title,
      required this.body,
      this.loading = false,
      this.onTap})
      : super(key: key);

  const EventInfo.loading(
      {Key? key,
      this.icon = Icons.hourglass_empty,
      this.title = "",
      this.body = "",
      this.loading = true,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          !loading
              ? Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: primary.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: primary,
                    size: 30,
                  ),
                )
              : BuildLoading.buildRectangularLoading(height: 50, width: 50),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !loading
                  ? Text(
                      title,
                      style: const TextStyle(
                          color: neutral,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )
                  : BuildLoading.buildRectangularLoading(
                      height: 16, width: 100, verticalPadding: 3),
              !loading
                  ? Text(
                      body,
                      style: TextStyle(
                          color: neutral.shade700,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  : BuildLoading.buildRectangularLoading(
                      height: 18, width: 120, verticalPadding: 3)
            ],
          )
        ],
      ),
    );
  }
}
