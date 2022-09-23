import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

class NetworkImageContainer extends StatelessWidget {
  final double width;
  final double height;
  final String? image;
  final Widget? child;
  const NetworkImageContainer({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.image,
    Widget? child,
  })  : child = child ?? const SizedBox.shrink(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: image != null
          ? BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(image!),
                fit: BoxFit.cover,
              ),
            )
          : BoxDecoration(
              color: neutral.shade400,
            ),
      child: child,
    );
  }
}
