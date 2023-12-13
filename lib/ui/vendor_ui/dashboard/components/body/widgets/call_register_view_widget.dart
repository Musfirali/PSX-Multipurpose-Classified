import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../custom_ui/user/register/component/register_view.dart';

class CallRegisterView extends StatelessWidget {
  const CallRegisterView(
      {required this.animationController,
      required this.currentIndex,
      required this.updateSelectedIndexWithAnimationUserId,
      required this.updateSelectedIndexWithAnimation});
  final AnimationController animationController;
  final int currentIndex;
  final Function updateSelectedIndexWithAnimationUserId;
  final Function updateSelectedIndexWithAnimation;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(scrollDirection: Axis.vertical, slivers: <Widget>[
      CustomRegisterView(
          animationController: animationController,
          onRegisterSelected: (User user) {
            if (user.needVerify != PsConst.ONE) {
              updateSelectedIndexWithAnimationUserId(
                  'home__menu_drawer_profile'.tr,
                  PsConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT,
                  user.userId);
            } else {
              if (currentIndex ==
                  PsConst.REQUEST_CODE__MENU_REGISTER_FRAGMENT) {
                updateSelectedIndexWithAnimation('home__verify_email'.tr,
                    PsConst.REQUEST_CODE__MENU_VERIFY_EMAIL_FRAGMENT);
              } else if (currentIndex ==
                  PsConst.REQUEST_CODE__DASHBOARD_REGISTER_FRAGMENT) {
                updateSelectedIndexWithAnimation('home__verify_email'.tr,
                    PsConst.REQUEST_CODE__DASHBOARD_VERIFY_EMAIL_FRAGMENT);
              } else {
                updateSelectedIndexWithAnimationUserId(
                    'home__menu_drawer_profile'.tr,
                    PsConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT,
                    user.userId);
              }
            }
          },
          goToLoginSelected: () {
            animationController.reverse().then<dynamic>((void data) {
              // if (!mounted) {
              //   return;
              // }
              if (currentIndex ==
                  PsConst.REQUEST_CODE__MENU_REGISTER_FRAGMENT) {
                updateSelectedIndexWithAnimation(
                    'home_login'.tr, PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT);
              }
              if (currentIndex ==
                  PsConst.REQUEST_CODE__DASHBOARD_REGISTER_FRAGMENT) {
                updateSelectedIndexWithAnimation('home_login'.tr,
                    PsConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT);
              }
            });
          })
    ]);
  }
}
