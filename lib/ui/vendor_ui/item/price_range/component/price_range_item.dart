import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';

class PriceRangeItem extends StatelessWidget {
  const PriceRangeItem(
      {Key? key,
      required this.dollarCount,
      this.animationController,
      this.animation,
      required this.isSelected})
      : super(key: key);

  final int dollarCount;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    const String str = '\$\$\$\$\$';
    final String firstPart = str.substring(0, dollarCount);
    final String secondPart = str.substring(dollarCount, str.length);
    animationController!.forward();
    return AnimatedBuilder(
      animation: animationController!,
      child: InkWell(
        onTap: () {
          Navigator.pop(context, dollarCount);
        },
        child: Container(
          height: PsDimens.space52,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Material(
            color: Utils.isLightMode(context)
                ? PsColors.achromatic200
                : PsColors.achromatic900,
            child: Padding(
              padding: const EdgeInsets.all(PsDimens.space16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Utils.isLightMode(context)
                                  ? PsColors.achromatic600
                                  : PsColors.achromatic100,
                            ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: firstPart,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Utils.isLightMode(context)
                                      ? PsColors.primary500
                                      : PsColors.primary300,
                                ),
                          ),
                          TextSpan(
                            text: secondPart,
                          ),
                        ]),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
      builder: (BuildContext contenxt, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 100 * (1.0 - animation!.value), 0.0),
              child: child),
        );
      },
    );
  }
}
