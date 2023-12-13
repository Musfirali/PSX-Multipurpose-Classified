import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../custom_ui/user/login/component/login_view.dart';

class CallLoginWidget extends StatelessWidget {
  const CallLoginWidget(
      {required this.animationController,
      required this.updateCurrentIndex,
      required this.updateUserCurrentIndex,
      required this.currentIndex});
  final Function updateCurrentIndex;
  final Function updateUserCurrentIndex;
  final AnimationController? animationController;
  final int? currentIndex;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(scrollDirection: Axis.vertical, slivers: <Widget>[
      CustomLoginView(
        animationController: animationController,
        animation: curveAnimation(animationController!),
        onGoogleSignInSelected: (String userId) {
            if (currentIndex == PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT) {
              updateUserCurrentIndex('home__menu_drawer_profile'.tr,
                  PsConst.REQUEST_CODE__MENU_USER_PROFILE_FRAGMENT, userId);
            } else {
              updateUserCurrentIndex(
                  'home__menu_drawer_profile'.tr,
                  PsConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT,
                  userId);
            }
        },
        onFbSignInSelected: (String userId) {
            if (currentIndex == PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT) {
              updateUserCurrentIndex('home__menu_drawer_profile'.tr,
                  PsConst.REQUEST_CODE__MENU_USER_PROFILE_FRAGMENT, userId);
            } else {
              updateUserCurrentIndex(
                  'home__menu_drawer_profile'.tr,
                  PsConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT,
                  userId);
            }
        },
        onPhoneSignInSelected: () {
          if (currentIndex == PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT) {
            updateCurrentIndex('home_phone_signin'.tr,
                PsConst.REQUEST_CODE__MENU_PHONE_SIGNIN_FRAGMENT);
          } else if (currentIndex ==
              PsConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT) {
            updateCurrentIndex('home_phone_signin'.tr,
                PsConst.REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT);
          } else if (currentIndex ==
              PsConst.REQUEST_CODE__MENU_SELECT_WHICH_USER_FRAGMENT) {
            updateCurrentIndex('home_phone_signin'.tr,
                PsConst.REQUEST_CODE__MENU_PHONE_SIGNIN_FRAGMENT);
          } else if (currentIndex ==
              PsConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT) {
            updateCurrentIndex('home_phone_signin'.tr,
                PsConst.REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT);
          } else {
            updateCurrentIndex('home_phone_signin'.tr,
                PsConst.REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT);
          }
        },
        onProfileSelected: (String userId) {
            if (currentIndex == PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT) {
              updateUserCurrentIndex('home__menu_drawer_profile'.tr,
                  PsConst.REQUEST_CODE__MENU_USER_PROFILE_FRAGMENT, userId);
            } else {
              updateUserCurrentIndex(
                  'home__menu_drawer_profile'.tr,
                  PsConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT,
                  userId);
            }
        },
        onForgotPasswordSelected: () {
          if (currentIndex == PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT) {
            updateCurrentIndex('home__forgot_password'.tr,
                PsConst.REQUEST_CODE__MENU_FORGOT_PASSWORD_FRAGMENT);
          } else {
            updateCurrentIndex('home__forgot_password'.tr,
                PsConst.REQUEST_CODE__DASHBOARD_FORGOT_PASSWORD_FRAGMENT);
          }
        },
        onSignInSelected: () {
          if (currentIndex == PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT) {
            updateCurrentIndex('home__register'.tr,
                PsConst.REQUEST_CODE__MENU_REGISTER_FRAGMENT);
          } else {
            updateCurrentIndex('home__register'.tr,
                PsConst.REQUEST_CODE__DASHBOARD_REGISTER_FRAGMENT);
          }
        },
      ),
    ]);
  }
}
