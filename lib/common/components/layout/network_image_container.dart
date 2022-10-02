import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/build_loading.dart';

class NetworkImageContainer extends StatelessWidget {
  final double width;
  final double height;
  final String? image;
  final Widget? child;
  final double? emptyImageIconTopPadding;
  const NetworkImageContainer({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.image,
    Widget? child,
    this.emptyImageIconTopPadding,
  })  : child = child ?? const SizedBox.shrink(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return image != null
        ? SizedBox(
            width: width,
            height: height,
            child: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 0),
              placeholderFadeInDuration: const Duration(milliseconds: 0),
              fadeOutDuration: const Duration(milliseconds: 0),
              imageUrl: image!,
              imageBuilder: (context, imageProvider) => Container(
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
            ),
          )
        : buildDefaultContainer();
  }

  Widget buildDefaultContainer() {
    return Container(
      color: primary.shade300,
      width: width,
      height: height,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned(
            top: emptyImageIconTopPadding,
            child: Image.asset("lib/common/assets/images/NoEventImageIcon.png"),
          ),
          child ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
