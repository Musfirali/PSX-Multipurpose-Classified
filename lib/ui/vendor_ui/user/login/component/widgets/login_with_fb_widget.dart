import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../common/ps_button_widget.dart';

class LoginWithFbWidget extends StatelessWidget {
  const LoginWithFbWidget(
      {required this.onFbSignInSelected,
      required this.callBackAfterLoginSuccess});

  final Function? onFbSignInSelected, callBackAfterLoginSuccess;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    return Container(
        margin: const EdgeInsets.only(
          top: PsDimens.space16, 
          left: PsDimens.space16, 
          right: PsDimens.space16),
      child: PSButtonWithIconWidget(
          titleText: 'login__fb_signin'.tr,
          icon: Icons.facebook_rounded, //FontAwesome.facebook_official,
          colorData: PsColors.facebookColor,
          onPressed: () async {
            await userProvider.loginWithFacebookId(
                context, onFbSignInSelected, callBackAfterLoginSuccess,langProvider!.currentLocale.languageCode);
          }),
    );
  }
}
