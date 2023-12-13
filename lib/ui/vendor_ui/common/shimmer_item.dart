import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';

class ShimmerItem extends StatelessWidget {
  const ShimmerItem();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: PsColors.achromatic100,
        highlightColor:
            Utils.isLightMode(context) ? PsColors.achromatic100 : PsColors.achromatic800,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: PsColors.achromatic900,
            borderRadius:
                const BorderRadius.all(Radius.circular(PsDimens.space2)),
          ),
        ));
  }
}
