import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/ui/vendor_ui/user/phone/component/verify_phone/widgets/resend_code_widget.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/phone_login_parameter_holder.dart';
import '../../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/dialog/warning_dialog_view.dart';
import '../../../../../common/ps_button_widget.dart';
import '../../../../../common/ps_email_textfield_widget.dart';

class VerificationInPhoneVerifyWidget extends StatefulWidget {
  const VerificationInPhoneVerifyWidget(
      {required this.userName,
      required this.phoneNumber,
      required this.phoneId,
      this.onProfileSelected,
      required this.onSignInSelected});

  final String? userName;
  final String? phoneNumber;
  final String phoneId;
  final Function? onProfileSelected;
  final Function? onSignInSelected;

  @override
  __TextFieldAndButtonWidgetState createState() =>
      __TextFieldAndButtonWidgetState();
}

class __TextFieldAndButtonWidgetState
    extends State<VerificationInPhoneVerifyWidget> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController userIdTextField = TextEditingController();
  late PsValueHolder psValueHolder;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);
    return Column(children: <Widget>[
      PsEmailTextFieldWidget(
        textEditingController: codeController,
        hintText: 'phone_otp_hint'.tr,
      ),
      const SizedBox(
        height: PsDimens.space4,
      ),
      ResendCodeWidget(
        onSignInSelected: widget.onSignInSelected,
        userName: widget.userName!,
        userPhone: widget.phoneNumber!.replaceFirst(RegExp(r'-'), ''),
      ),
      const SizedBox(
        height: PsDimens.space4,
      ),
      Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space16, right: PsDimens.space16),
        child: PSButtonWidget(
          colorData: Theme.of(context).primaryColor,
          hasShadow: true,
          width: double.infinity,
          titleText: 'login__submit'.tr,
          onPressed: () async {
            if (await Utils.checkInternetConnectivity()) {
              if (codeController.text.isEmpty) {
                callWarningDialog(context, 'warning_dialog__code_require'.tr);
              } else if (codeController.text.length != 6) {
                callWarningDialog(context, 'Verification OTP code is wrong');
              } else {
                final fb_auth.User? user =
                    fb_auth.FirebaseAuth.instance.currentUser;

                if (user != null) {
             
                  print('correct code');

                      await gotoProfile(
                          context,
                          user.uid,
                          widget.userName,
                          widget.phoneNumber,
                          provider,
                          widget.onProfileSelected);
                } else {
                  final fb_auth.AuthCredential credential =
                      fb_auth.PhoneAuthProvider.credential(
                          verificationId: widget.phoneId,
                          smsCode: codeController.text);

                  try {
                    await fb_auth.FirebaseAuth.instance
                        .signInWithCredential(credential)
                        .then((fb_auth.UserCredential user) async {
                      print('correct code again');
                      
                     await gotoProfile(
                          context,
                          user.user!.uid,
                          widget.userName,
                          widget.phoneNumber,
                          provider,
                          widget.onProfileSelected);
                      
                    });
                  } on Exception {
                    print('show error');
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorDialog(
                            message: 'error_dialog__code_wrong'.tr,
                          );
                        });
                  }
                }
              }
            }
          },
        ),
      )
    ]);
  }

  dynamic callWarningDialog(BuildContext context, String text) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(
            message: text.tr,
            onPressed: () {},
          );
        });
  }

  dynamic gotoProfile(
      BuildContext context,
      String phoneId,
      String? userName,
      String? phoneNumber,
      UserProvider provider,
      Function? onProfileSelected) async {
    if (await Utils.checkInternetConnectivity()) {
      final PhoneLoginParameterHolder phoneLoginParameterHolder =
          PhoneLoginParameterHolder(
        phoneId: phoneId,
        userName: userName,
        userPhone: phoneNumber,
        deviceToken: provider.psValueHolder!.deviceToken,
        platformName: PsConst.PLATFORM,
        deviceInfo: psValueHolder.deviceModelName,
        deviceId: psValueHolder.deviceUniqueId,
      );

      final PsResource<User> _apiStatus = await provider.postPhoneLogin(
          phoneLoginParameterHolder.toMap(),
          langProvider.currentLocale.languageCode);

      if (_apiStatus.data != null) {
        await provider.checkForUserNameNeeded(PsConst.PHONE_LOGIN,_apiStatus.data?.userPhone);
        await provider.replaceVerifyUserData('', '', '', '');
        await provider.replaceLoginUserId(_apiStatus.data!.userId!);
        await provider.replaceLoginUserName(_apiStatus.data!.userName!);

        if (onProfileSelected != null) {
          await provider.replaceVerifyUserData('', '', '', '');
          await provider.replaceLoginUserId(_apiStatus.data!.userId!);
          await provider.replaceLoginUserName(_apiStatus.data!.userName!);
          await onProfileSelected(_apiStatus.data!.userId);
        } else if (psValueHolder.isForceLogin!) {
          if (psValueHolder.isLanguageConfig! &&
              psValueHolder.showOnboardLanguage) {
            Navigator.pushReplacementNamed(context, RoutePaths.languagesetting);
          } else {
            if (psValueHolder.locationId != null) {
              Navigator.pushReplacementNamed(
                context,
                RoutePaths.home,
              );
            } else {
              Navigator.pushReplacementNamed(
                context,
                RoutePaths.itemLocationFirst,
              );
            }
          }
        } else {
          Navigator.pop(context, _apiStatus.data);
        }
        print('you can go to profille');
      } else {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: _apiStatus.message,
              );
            });
      }
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'error_dialog__no_internet'.tr,
            );
          });
    }
  }
}
