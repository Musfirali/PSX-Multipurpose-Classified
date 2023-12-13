import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class ActivityLogMenuWidget extends StatelessWidget {
  const ActivityLogMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.history,
            size: 22,
            color: Utils.isLightMode(context)
                ? PsColors.achromatic800 : PsColors.achromatic50),
        minLeadingWidth: 0,
        title: Text(
          'home__drawer_menu_activity_log'.tr,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        onTap: () {
          Navigator.pop(context);
          if (updateSelectedIndexWithAnimation != null) {
            updateSelectedIndexWithAnimation!(
                'home__drawer_menu_activity_log'.tr,
                PsConst.REQUEST_CODE__MENU_ACTIVITY_LOG_FRAGMENT);
          }
        });
  }
}
