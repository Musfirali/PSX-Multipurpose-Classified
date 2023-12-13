import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../common/dialog/share_app_dialog.dart';

class ShareThisAppMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.share_outlined,
        size: 22,
        color: Utils.isLightMode(context)
            ? PsColors.achromatic800 : PsColors.achromatic50, //PsColors.primary500,
      ),
      minLeadingWidth: 0,
      title: Text(
        'home__menu_drawer_share_this_app'.tr,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(fontWeight: FontWeight.w400),
      ),
      onTap: () {
        Navigator.pop(context);
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ShareAppDialog(
                onPressed: () {
                  Navigator.pop(context, true);
                },
              );
            });
      },
    );
  }
}
