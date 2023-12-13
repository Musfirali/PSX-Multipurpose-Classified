import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../custom_ui/user/forgot_password/component/verify_forgot_password_view.dart';

class CallVerifyForgotPasswordWidget extends StatelessWidget {
  const CallVerifyForgotPasswordWidget({
    required this.updateSelectedIndexWithAnimation,
    required this.animationController,
    required this.currentIndex,
    required this.userEmail,
  });

  final Function updateSelectedIndexWithAnimation;
  final int? currentIndex;
  final AnimationController? animationController;
  final String? userEmail;

  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: CustomVerifyForgotPasswordView(
          animationController: animationController,
          userEmail: userEmail,
          onUpdateForgotChangeSelected: () {
            if (currentIndex ==
                PsConst.REQUEST_CODE__MENU_VERIFY_FORGOT_PASSWORD_FRAGMENT) {
              updateSelectedIndexWithAnimation(
                  'forgot_psw__update_password_title'.tr,
                  PsConst
                      .REQUEST_CODE__DASHBOARD_UPDATE_FORGOT_PASSWORD_FRAGMENT);
            }
          },
          onToForgotPasswordSelected: () {
            animationController!.reverse().then<dynamic>((void data) {
              if (currentIndex ==
                  PsConst.REQUEST_CODE__MENU_VERIFY_FORGOT_PASSWORD_FRAGMENT) {
                updateSelectedIndexWithAnimation(
                    'home_login'.tr, PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT);
              }
            });
          },
        ));
  }
}
