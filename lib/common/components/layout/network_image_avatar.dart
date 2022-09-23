import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  const NetworkImageAvatar({
    Key? key,
    required this.imageUrl,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageUrl != null
          ? CachedNetworkImageProvider(imageUrl!)
          : const AssetImage('lib/common/assets/images/CircleAvatarDefault.png')
              as ImageProvider,
    );
  }
}
