import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class DefaultImageTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: PsColors.achromatic500,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PsDimens.space2)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: PsDimens.space4, vertical: PsDimens.space1),
            child: Text(
              'item_entry__default_image'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: PsColors.achromatic900),
            ),
          ),
        ),
      ),
    );
  }
}
