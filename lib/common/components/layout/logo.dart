import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  final double? width;
  final double? height;
  final LogoType? type;
  const Logo({Key? key, this.width, this.height, this.type = LogoType.logo})
      : super(key: key);
  const Logo.text(
      {Key? key, this.width, this.height, this.type = LogoType.text})
      : super(key: key);
  const Logo.slogan(
      {Key? key, this.width, this.height, this.type = LogoType.slogan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: type == LogoType.logo
            ? 'Logo'
            : type == LogoType.text
                ? 'Text'
                : 'Slogan',
        child: SvgPicture.asset(
          type == LogoType.logo
              ? 'lib/common/assets/images/GatherlyLogo.svg'
              : type == LogoType.text
                  ? 'lib/common/assets/images/GatherlyLogoText.svg'
                  : 'lib/common/assets/images/GatherlyLogoSlogan.svg',
          width: width,
          height: height,
        ));
  }
}
