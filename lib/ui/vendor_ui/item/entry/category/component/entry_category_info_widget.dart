import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/constant/ps_dimens.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../core/vendor/utils/utils.dart';

class EntryCategoryInfoWidget extends StatelessWidget {

@override
  Widget build(BuildContext context) {
  return Container(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'item_entry_category_title'.tr,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Utils.isLightMode(context)
                    ? PsColors.text800
                    : PsColors.text50, 
                  fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: PsDimens.space12,
            left: PsDimens.space24,
            right: PsDimens.space24),
          child: Text(
              'item_entry_category_description'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Utils.isLightMode(context)
                    ? PsColors.text500
                    : PsColors.text300),
              textAlign: TextAlign.center,
            )),
        ]),
      );
  }
}