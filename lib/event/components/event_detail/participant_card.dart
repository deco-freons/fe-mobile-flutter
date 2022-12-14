import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/layout/network_image_avatar.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class ParticipantCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String location;
  final String? userImage;
  final VoidCallback onPressed;
  const ParticipantCard({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.onPressed,
    required this.userImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomRadius.xxl),
        boxShadow: [
          BoxShadow(blurRadius: 4, color: neutral.shade300),
        ],
      ),
      child: InkWell(
        onTap: onPressed,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CustomRadius.xxl)),
          margin: EdgeInsets.zero,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(CustomPadding.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NetworkImageAvatar(imageUrl: userImage, radius: 25),
                const SizedBox(
                  width: 12,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$firstName $lastName',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: CustomFontSize.lg,
                            fontWeight: FontWeight.bold,
                            color: neutral.shade700),
                      ),
                      Text(
                        location,
                        style: TextStyle(
                            fontSize: CustomFontSize.base,
                            fontWeight: FontWeight.bold,
                            color: neutral.shade300),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
