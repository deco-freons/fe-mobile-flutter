import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/common/components/shimmer_widget.dart';

class BuildLoading {
  static Widget buildRectangularLoading(
      {required double height,
      double width = double.infinity,
      double verticalPadding = 0,
      int count = 1,
      double borderRadius = 5}) {
    if (count > 1) {
      return Column(
        children: List.filled(
          count,
          Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: ShimmerWidget.rectangular(
              height: height,
              width: width,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: ShimmerWidget.rectangular(
        height: height,
        width: width,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
