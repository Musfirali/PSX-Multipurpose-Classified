import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../custom_ui/user/forgot_password/component/forgot_password_view.dart';

class CallForgotPasswordView extends StatelessWidget {
  const CallForgotPasswordView(
      {required this.animationController,
      required this.currentIndex,
      required this.updateSelectedIndexWithAnimation});
  final AnimationController animationController;
  final int currentIndex;
  final Function updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(scrollDirection: Axis.vertical, slivers: <Widget>[
      CustomForgotPasswordView(
        animationController: animationController,
        onVerifyForgotPasswordSelected: () {
          if (currentIndex ==
              PsConst.REQUEST_CODE__DASHBOARD_FORGOT_PASSWORD_FRAGMENT) {
            updateSelectedIndexWithAnimation('home__verify_forgot_password'.tr,
                PsConst.REQUEST_CODE__MENU_VERIFY_FORGOT_PASSWORD_FRAGMENT);
          } else if (currentIndex ==
              PsConst.REQUEST_CODE__MENU_FORGOT_PASSWORD_FRAGMENT) {
            updateSelectedIndexWithAnimation('home__verify_forgot_password'.tr,
                PsConst.REQUEST_CODE__MENU_VERIFY_FORGOT_PASSWORD_FRAGMENT);
          }
        },
        goToLoginSelected: () {
          animationController.reverse().then<dynamic>((void data) {
            if (currentIndex ==
                PsConst.REQUEST_CODE__MENU_FORGOT_PASSWORD_FRAGMENT) {
              updateSelectedIndexWithAnimation(
                  'home_login'.tr, PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT);
            }
            if (currentIndex ==
                PsConst.REQUEST_CODE__DASHBOARD_FORGOT_PASSWORD_FRAGMENT) {
              updateSelectedIndexWithAnimation('home_login'.tr,
                  PsConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT);
            }
          });
        },
      )
    ]);
  }
}
