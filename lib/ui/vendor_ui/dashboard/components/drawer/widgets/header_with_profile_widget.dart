import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../common/ps_ui_widget.dart';

class DrawerHeaderWidgetWithUserProfile extends StatefulWidget {
  @override
  __DrawerHeaderWidgetWithUserProfileState createState() =>
      __DrawerHeaderWidgetWithUserProfileState();
}

class __DrawerHeaderWidgetWithUserProfileState
    extends State<DrawerHeaderWidgetWithUserProfile> {
  UserProvider? provider;
  late PsValueHolder psValueHolder;
  late AppLocalization langProvider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);
    if (provider?.data.data?.userId != psValueHolder.loginUserId) {
      provider!.getUser(psValueHolder.loginUserId ?? '',
          langProvider.currentLocale.languageCode);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            child: PsNetworkCircleImageForUser(
              photoKey: '',
              imagePath: provider!.user.data?.userCoverPhoto ?? '',
              boxfit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: PsDimens.space16,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  provider!.user.data?.name ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic900
                          : PsColors.achromatic50),
                ),
                Text(
                  provider!.user.data?.userEmail ?? '',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic900
                          : PsColors.achromatic50),
                ),
              ]),
        ],

        // decoration: BoxDecoration(color: PsColors.mainColor),
      ),
    );
  }
}
