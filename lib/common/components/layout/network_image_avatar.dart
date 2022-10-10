import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';

class NetworkImageAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final String placeholderImage;
  const NetworkImageAvatar(
      {Key? key,
      required this.imageUrl,
      required this.radius,
      this.placeholderImage =
          'lib/common/assets/images/CircleAvatarDefault.png'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 0),
            placeholderFadeInDuration: const Duration(milliseconds: 0),
            fadeOutDuration: const Duration(milliseconds: 0),
            imageUrl: imageUrl!,
            imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: radius,
                backgroundImage: CachedNetworkImageProvider(imageUrl!)),
            placeholder: (context, url) => BuildLoading.buildRectangularLoading(
                height: 2 * radius, width: 2 * radius, borderRadius: 100),
            errorWidget: (context, url, error) => buildDefaultAvatar(),
          )
        : buildDefaultAvatar();
  }

  Widget buildDefaultAvatar() {
    return CircleAvatar(
      radius: radius,
      backgroundColor: primary.shade300,
      backgroundImage: imageUrl != null
          ? CachedNetworkImageProvider(imageUrl!)
          : AssetImage(placeholderImage) as ImageProvider,
    );
  }
}
