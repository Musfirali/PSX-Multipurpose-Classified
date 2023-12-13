import 'package:flutter/material.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';

class MultiSelectionListItem extends StatelessWidget {
  const MultiSelectionListItem({
    Key? key,
    required this.animation,
    required this.controller,
    required this.isSelected,
    required this.onTap,
    required this.value,
  }) : super(key: key);
  final Animation<double> animation;
  final AnimationController controller;
  final bool isSelected;
  final Function()? onTap;
  final String value;
  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
            opacity: animation,
            child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 100 * (1.0 - animation.value), 0.0),
                child: child));
      },
      child: Container(
        height: PsDimens.space52,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Material(
          color: Utils.isLightMode(context) ? PsColors.achromatic100
              : PsColors.achromatic900,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      value,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Utils.isLightMode(context)
                          ? PsColors.text800
                          : PsColors.achromatic50),
                    ),
                    Container(
                        child: isSelected
                            ? Icon(Icons.check_circle,
                                color: Theme.of(context)
                                    .iconTheme
                                    .copyWith(color: Theme.of(context).primaryColor)
                                    .color)
                            : const SizedBox())
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
