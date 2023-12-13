import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../common/ps_button_widget_with_round_corner.dart';

class LoginHeaderMenuWidget extends StatelessWidget {
  const LoginHeaderMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: PSButtonWidgetRoundCorner(
        hasBorder: true,
        colorData: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
        titleTextColor:
            Utils.isLightMode(context) ? PsColors.achromatic900 : PsColors.achromatic50,
        hasShadow: false,
        width: 80,
        titleText: 'login__sign_in'.tr,
        onPressed: () async {
          Navigator.pop(context);
          if (updateSelectedIndexWithAnimation != null) {
            updateSelectedIndexWithAnimation!(
                'login__title'.tr, PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT);
          }
        },
      ),
    );
  }
}
