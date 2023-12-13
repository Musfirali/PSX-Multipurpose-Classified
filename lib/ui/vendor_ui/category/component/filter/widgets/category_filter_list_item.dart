import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/category.dart';
import '../../../../common/shimmer_item.dart';

class CategoryFilterListItem extends StatelessWidget {
  const CategoryFilterListItem(
      {Key? key,
      required this.category,
      required this.animationController,
      required this.animation,
      this.isLoading = false,
      required this.isSelected})
      : super(key: key);

  final Category category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return Container(
      height: PsDimens.space52,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: isLoading
          ? const ShimmerItem()
          : FadeTransition(
              opacity: animation!,
              child: AnimatedBuilder(
                animation: animationController!,
                child: Material(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic100
                      : PsColors.achromatic900,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context, category);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(PsDimens.space16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            category.catName!,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
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
                builder: (BuildContext contenxt, Widget? child) {
                  return FadeTransition(
                      opacity: animation!,
                      child: Transform(
                          transform: Matrix4.translationValues(
                              0.0, 100 * (1.0 - animation!.value), 0.0),
                          child: child));
                },
              ),
            ),
    );
  }
}
