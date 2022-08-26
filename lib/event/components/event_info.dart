import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class EventInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final VoidCallback? onTap;
  const EventInfo(
      {Key? key,
      required this.icon,
      required this.title,
      required this.body,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
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
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: neutral, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                body,
                style: TextStyle(
                    color: neutral.shade700,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
