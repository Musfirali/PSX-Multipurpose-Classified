import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';

class LocationTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: PsDimens.space28,
          right: PsDimens.space28,
          top: PsDimens.space16),
      child: Center(
        child: Text('choose_location'.tr,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20,
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic800 : PsColors.achromatic50)),
      ),
    );
  }
}
