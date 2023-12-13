import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import '../../../core/vendor/constant/ps_dimens.dart';

class CheckedIconWidget extends StatelessWidget {
  const CheckedIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(right: PsDimens.space2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: Center(
        child: Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: PsColors.achromatic50,
          ),
        ),
      ),
    );
  }
}
