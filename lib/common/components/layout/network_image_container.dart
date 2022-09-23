import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';

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
    return image != null
        ? CachedNetworkImage(
            imageUrl: image!,
            imageBuilder: (context, imageProvider) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: child,
            ),
            placeholder: (context, url) =>
                BuildLoading.buildRectangularLoading(height: height),
            errorWidget: (context, url, error) => buildDefaultContainer(),
          )
        : buildDefaultContainer();
  }

  Widget buildDefaultContainer() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: neutral.shade400,
      ),
      child: child,
    );
  }
}
