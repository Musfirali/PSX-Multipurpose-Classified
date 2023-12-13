import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class DeleteImageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: PsDimens.space18,
      height: PsDimens.space18,
      margin:
          const EdgeInsets.only(right: PsDimens.space2, top: PsDimens.space2),
      decoration: BoxDecoration(
        color: PsColors.achromatic50,
        borderRadius: BorderRadius.circular(PsDimens.space28),
      ),
      child: Icon(
        Icons.clear,
        size: 18,
        color: PsColors.achromatic900,
      ),
    );
  }
}
