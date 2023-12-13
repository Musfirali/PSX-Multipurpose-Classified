import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../custom_ui/user/phone/component/verify_phone/verify_phone_view.dart';

class CallVerifyPhoneWidget extends StatelessWidget {
  const CallVerifyPhoneWidget(
      {this.userName,
      this.phoneNumber,
      required this.phoneId,
      required this.updateCurrentIndex,
      required this.updateUserCurrentIndex,
      required this.animationController,
      required this.currentIndex});

  final String? userName;
  final String? phoneNumber;
  final String phoneId;
  final Function updateCurrentIndex;
  final Function updateUserCurrentIndex;
  final int? currentIndex;
  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: CustomVerifyPhoneView(
          userName: userName,
          phoneNumber: phoneNumber,
          phoneId: phoneId,
          animationController: animationController,
          onProfileSelected: (String userId) {
            if (currentIndex ==
                PsConst.REQUEST_CODE__MENU_PHONE_VERIFY_FRAGMENT) {
              updateUserCurrentIndex('home__menu_drawer_profile'.tr,
                  PsConst.REQUEST_CODE__MENU_USER_PROFILE_FRAGMENT, userId);
            } else {
              //PsConst.REQUEST_CODE__DASHBOARD_PHONE_VERIFY_FRAGMENT
              updateUserCurrentIndex(
                  'home__menu_drawer_profile'.tr,
                  PsConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT,
                  userId);
            }
          },
          onSignInSelected: () {
            if (currentIndex ==
                PsConst.REQUEST_CODE__MENU_PHONE_VERIFY_FRAGMENT) {
              updateCurrentIndex('home__register'.tr,
                  PsConst.REQUEST_CODE__MENU_PHONE_SIGNIN_FRAGMENT);
            } else if (currentIndex ==
                PsConst.REQUEST_CODE__DASHBOARD_PHONE_VERIFY_FRAGMENT) {
              updateCurrentIndex('home__register'.tr,
                  PsConst.REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT);
            }
          },
        ));
  }
}
