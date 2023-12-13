import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class SoldOutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /** UI Section is here */
    return Flexible(
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'dashboard__sold_out'.tr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: PsColors.achromatic50,
                height: 1.7,
                fontWeight: FontWeight.w500),
          ),
        ),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PsDimens.space4),
            color: PsColors.error500),
      ),
    );
  }
}
