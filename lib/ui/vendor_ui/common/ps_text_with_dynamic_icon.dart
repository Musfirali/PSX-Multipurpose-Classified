import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';

class PsTextWidgetWithDynamicIcon extends StatelessWidget {
  const PsTextWidgetWithDynamicIcon({
    this.text,
    this.height = PsDimens.space44,
    required this.icon,
    this.iconRotate = false,
  });

  final String? text;
  final double height;
  final bool iconRotate;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: height,
          margin: const EdgeInsets.only(
              left: PsDimens.space16,
              right: PsDimens.space16,
              top: PsDimens.space8),
          padding: const EdgeInsets.symmetric(
            horizontal: PsDimens.space12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: Utils.isLightMode(context) ? PsColors.text300 : PsColors.text50),
          ),
          child: Row(
            children: <Widget>[
              if (iconRotate)
                Transform.rotate(
                  angle: 90 * pi / 180,
                  child: icon,
                )
              else
                icon,
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  text!,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Utils.isLightMode(context)
                          ? PsColors.text800
                          : PsColors.text200),
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
