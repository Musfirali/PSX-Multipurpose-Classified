import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class ForceUpdateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Container(
      margin: const EdgeInsets.only(
          top: PsDimens.space8,
          left: PsDimens.space32,
          right: PsDimens.space32),
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        height: 45,
        minWidth: double.infinity,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
        ),
        child: Text(
          'force_update__update'.tr,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: PsColors.achromatic50),
        ),
        onPressed: () async {
          if (Platform.isIOS) {
            Utils.launchAppStoreURL(iOSAppId: psValueHolder.iosAppStoreId);
          } else if (Platform.isAndroid) {
            Utils.launchURL();
          }
        },
      ),
    );
  }
}
