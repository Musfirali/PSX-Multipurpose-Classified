import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../custom_ui/user/phone/component/sign_in/phone_sign_in_view.dart';

class CallPhoneSignInWidget extends StatelessWidget {
  const CallPhoneSignInWidget(
      {required this.animationController,
      required this.currentIndex,
      required this.updateSelectedIndexWithAnimation,
      required this.updatePhoneInfo});
  final AnimationController animationController;
  final int currentIndex;
  final Function updateSelectedIndexWithAnimation;
  final Function updatePhoneInfo;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(scrollDirection: Axis.vertical, slivers: <Widget>[
      CustomPhoneSignInView(
          animationController: animationController,
          goToLoginSelected: () {
            animationController.reverse().then<dynamic>((void data) {
              // if (!mounted) {
              //   return;
              // }
              if (currentIndex ==
                  PsConst.REQUEST_CODE__MENU_PHONE_SIGNIN_FRAGMENT) {
                updateSelectedIndexWithAnimation(
                    'home_login'.tr, PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT);
              }
              if (currentIndex ==
                  PsConst.REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT) {
                updateSelectedIndexWithAnimation('home_login'.tr,
                    PsConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT);
              }
            });
          },
          phoneSignInSelected: (String name, String phoneNo, String verifyId) {
            updatePhoneInfo(name, phoneNo, verifyId);
            if (currentIndex ==
                PsConst.REQUEST_CODE__MENU_PHONE_SIGNIN_FRAGMENT) {
              updateSelectedIndexWithAnimation('home_verify_phone'.tr,
                  PsConst.REQUEST_CODE__MENU_PHONE_VERIFY_FRAGMENT);
            }
            if (currentIndex ==
                PsConst.REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT) {
              updateSelectedIndexWithAnimation('home_verify_phone'.tr,
                  PsConst.REQUEST_CODE__DASHBOARD_PHONE_VERIFY_FRAGMENT);
            }
          })
    ]);
  }
}
