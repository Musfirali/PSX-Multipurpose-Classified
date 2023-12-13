import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class RateThisAppMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return ListTile(
      leading: Icon(
        Icons.thumb_up_outlined,
        size: 22,
        color: Utils.isLightMode(context)
            ? PsColors.achromatic800 : PsColors.achromatic50, //PsColors.primary500,
      ),
      minLeadingWidth: 0,
      title: Text(
        'home__menu_drawer_rate_this_app'.tr,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(fontWeight: FontWeight.w400),
      ),
      onTap: () {
        Navigator.pop(context);
        if (Platform.isIOS) {
          Utils.launchAppStoreURL(
              iOSAppId: psValueHolder.iosAppStoreId, writeReview: true);
        } else {
          Utils.launchURL();
        }
      },
    );
  }
}
