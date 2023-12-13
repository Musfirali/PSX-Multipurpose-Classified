import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../common/dialog/apply_bluemark_dialog.dart';


class BluemarkInfoWidget extends StatelessWidget {
  const BluemarkInfoWidget();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    final User user = userProvider.user.data!;

    Color backgroundColor = Colors.transparent;
    Color textColor = Colors.transparent;
    String bluemarkInfo = '';

    if (user.isNormalUser) {
      textColor = PsColors.info500;
      backgroundColor = PsColors.info500;
      bluemarkInfo = 'profile__apply_blue_mark'.tr;
    } else if (user.isUserWaitingForApproval) {
      textColor = PsColors.warning600;
      backgroundColor = PsColors.warning600;
      bluemarkInfo = 'profile__waiting_for_approval_blue_mark'.tr;
    } else if (user.isRejectedUser) {
      textColor = PsColors.warning800;
      backgroundColor = PsColors.warning800;
      bluemarkInfo = 'profile__rejected_blue_mark'.tr;
    } else if (user.isVefifiedBlueMarkUser) {
      textColor = PsColors.info500;
      backgroundColor = PsColors.info500;
      bluemarkInfo = 'seller_info_tile__verified'.tr;
    } else {
      textColor = PsColors.info500;
      backgroundColor = PsColors.info500;
      bluemarkInfo = 'profile__apply_blue_mark'.tr;
    }

    return Column(
      children: <Widget>[
        const SizedBox(height: PsDimens.space4),
        InkWell(
          onTap: () async {
            if (user.isNormalUser || user.isRejectedUser) {
              final dynamic returnData = await showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return ApplyBlueMarkDialog(userProvider);
                  });
              if (returnData != null && returnData) {
                final PsValueHolder valueHolder =
                    Provider.of<PsValueHolder>(context, listen: false);
                userProvider.getUser(valueHolder.loginUserId,langProvider!.currentLocale.languageCode);
              }
            }
          },
          /**
           * UI SECTION
           */
          child: Container(
            width: 120,
            height: 50,
            //color: backgroundColor,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PsDimens.space4),
                color:  PsColors.achromatic200),
           // padding: const EdgeInsets.only(left:PsDimens.space8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.verified_user,
                  color: backgroundColor,
                ),
                const SizedBox(
                  width: PsDimens.space8,
                ),
                Container(
                 // width: 80,
                  child: Text(bluemarkInfo,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: textColor)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
