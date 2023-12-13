import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../custom_ui/user/forgot_password/component/update_forgot_password_view.dart';

class CallUpdateForgotPasswordWidget extends StatelessWidget {
  const CallUpdateForgotPasswordWidget({
    required this.updateSelectedIndexWithAnimation,
    required this.animationController,
    required this.currentIndex,
    required this.userId,
  });
  final Function updateSelectedIndexWithAnimation;
  final int? currentIndex;
  final AnimationController? animationController;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: CustomUpdateForgotPasswordView(
          userId: userId ?? '',
          goToLoginSelected: () {
            animationController!.reverse().then<dynamic>((void data) {
              if (currentIndex ==
                  PsConst
                      .REQUEST_CODE__DASHBOARD_UPDATE_FORGOT_PASSWORD_FRAGMENT) {
                updateSelectedIndexWithAnimation(
                    'home_login'.tr, PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT);
              }
               if (currentIndex ==
                  PsConst
                      .REQUEST_CODE__DASHBOARD_UPDATE_FORGOT_PASSWORD_FRAGMENT) {
                updateSelectedIndexWithAnimation(
                    'home_login'.tr, PsConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT);
              }
            });
          },
          goToVerifyPasswordSelected: () {
            animationController!.reverse().then<dynamic>((void data) {
              if (currentIndex ==
                  PsConst
                      .REQUEST_CODE__DASHBOARD_UPDATE_FORGOT_PASSWORD_FRAGMENT) {
                updateSelectedIndexWithAnimation(
                    'home__verify_forgot_password'.tr,
                    PsConst.REQUEST_CODE__MENU_VERIFY_FORGOT_PASSWORD_FRAGMENT);
              }
            });
          },
        ));
  }
}
