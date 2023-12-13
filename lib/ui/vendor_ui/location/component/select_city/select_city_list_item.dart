import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../common/check_icon_widget.dart';
import '../../../common/shimmer_item.dart';

class SelectCityListItem extends StatelessWidget {
  const SelectCityListItem(
      {Key? key,
      required this.itemLocation,
      required this.onTap,
      required this.animationController,
      required this.animation,
      this.isLoading = false,
      required this.isChecked})
      : super(key: key);

  final String? itemLocation;
  final Function? onTap;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(
        animation: animationController!,
        child: Column(
          children: <Widget>[
            Container(
              height: PsDimens.space48,
              child: isLoading
                  ? const ShimmerItem()
                  : InkWell(
                      highlightColor: PsColors.primary50,
                      onTap: onTap as void Function()?,
                      child: Ink(
                          child: ItemLocationListItemWidget(
                              isChecked: isChecked,
                              itemLocation: itemLocation))),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: PsDimens.space16,
                  right: PsDimens.space16,
                  bottom: PsDimens.space8),
              child: const Divider(
                height: PsDimens.space2,
              ),
            ),
          ],
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: animation!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 100 * (1.0 - animation!.value), 0.0),
                  child: child));
        });
  }
}

class ItemLocationListItemWidget extends StatelessWidget {
  const ItemLocationListItemWidget({
    Key? key,
    required this.itemLocation,
    required this.isChecked,
  }) : super(key: key);

  final String? itemLocation;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      child: Row(
        children: <Widget>[
          if (isChecked)
            const CheckedIconWidget()
          else
            Icon(
              Icons.circle_outlined,
              size: 22,
              color: PsColors.achromatic500,
            ),
          const SizedBox(
            width: PsDimens.space16,
          ),
          Text(
            itemLocation!,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
