import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/item_location_township.dart';
import '../../../common/shimmer_item.dart';

class EntryTownshipListItem extends StatelessWidget {
  const EntryTownshipListItem(
      {Key? key,
      required this.itemLocationTownship,
      this.animationController,
      this.animation,
      required this.isLoading,
      required this.isSelected})
      : super(key: key);

  final ItemLocationTownship itemLocationTownship;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(
      animation: animationController!,
      child: Container(
        height: PsDimens.space52,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: isLoading
            ? const ShimmerItem()
            : Material(
                color: Utils.isLightMode(context) ? PsColors.achromatic100
              : PsColors.achromatic900,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, itemLocationTownship);
                    print(itemLocationTownship.townshipName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(PsDimens.space16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          itemLocationTownship.townshipName!,
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text800
                                        : PsColors.achromatic50,
                                  ),
                        ),
                        if (isSelected)
                          const Icon(Icons.check_circle)
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
