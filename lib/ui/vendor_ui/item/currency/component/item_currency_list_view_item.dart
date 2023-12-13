import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/item_currency.dart';

class ItemCurrencyListViewItem extends StatelessWidget {
  const ItemCurrencyListViewItem(
      {Key? key,
      required this.itemCurrency,
      this.onTap,
      this.animationController,
      this.animation,
      required this.isSelected})
      : super(key: key);

  final ItemCurrency itemCurrency;
  final Function? onTap;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(
      animation: animationController!,
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Container(
          height: PsDimens.space52,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Material(
            color: Utils.isLightMode(context) ? PsColors.achromatic200
              : PsColors.achromatic900,
            child: Padding(
              padding: const EdgeInsets.all(PsDimens.space16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    itemCurrency.currencySymbol!,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Utils.isLightMode(context)
                              ? PsColors.text800
                              : PsColors.achromatic50,
                        ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check_circle,)
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
