import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/verify_phone_internt_holder.dart';
import '../../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/dialog/warning_dialog_view.dart';
import '../../../../../common/ps_button_widget.dart';

class PhoneSignInButton extends StatefulWidget {
  const PhoneSignInButton(
      {required this.nameController,
      required this.phoneController,
      required this.phoneSignInSelected});
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final Function? phoneSignInSelected;

  @override
  __SendButtonWidgetState createState() => __SendButtonWidgetState();
}

class __SendButtonWidgetState extends State<PhoneSignInButton> {
  UserProvider? provider;
  PsValueHolder? psValueHolder;

  Future<String?> verifyPhone() async {
    String? verificationId;
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      verificationId = verId;
      PsProgressDialog.dismissDialog();
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int? forceCodeResend]) {
      verificationId = verId;
      PsProgressDialog.dismissDialog();
      print('code has been send');

      if (widget.phoneSignInSelected != null) {
        widget.phoneSignInSelected!(
            widget.nameController.text,
            provider!.selectedCountryCode + '-' + widget.phoneController.text,
            verificationId);
      } else {
        Navigator.pushReplacementNamed(
            context, RoutePaths.user_phone_verify_container,
            arguments: VerifyPhoneIntentHolder(
                userName: widget.nameController.text,
                phoneNumber: provider!.selectedCountryCode +
                    '-' +
                    widget.phoneController.text,
                phoneId: verificationId));
      }
    };
    final PhoneVerificationCompleted verifySuccess = (AuthCredential user) {
      print('verify');
      PsProgressDialog.dismissDialog();
    };
    final PhoneVerificationFailed verifyFail =
        (FirebaseAuthException exception) {
      print('${exception.message}');
      PsProgressDialog.dismissDialog();
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: '${exception.message}',
            );
          });
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:
            provider!.selectedCountryCode + widget.phoneController.text,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(minutes: 2),
        verificationCompleted: verifySuccess,
        verificationFailed: verifyFail);
    print('phone no ::: ' +
        provider!.selectedCountryCode +
        widget.phoneController.text);
    return verificationId;
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

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return Container(
      height: 40,
      child: PSButtonWidget(
          colorData: Theme.of(context).primaryColor,
          hasShadow: false,
          width: double.infinity,
          titleText: 'login__submit'.tr,
          onPressed: () {
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  return ConfirmDialogView(
                      title: 'Confirmation'.tr,
                      description: 'phone_signin_confirmation'.tr,
                      leftButtonText: 'dialog__cancel'.tr,
                      rightButtonText: 'logout_dialog__confirm'.tr,
                      onAgreeTap: () async {
                        Navigator.pop(context);
                        if (widget.nameController.text.isEmpty) {
                          callWarningDialog(
                              context, 'warning_dialog__input_name'.tr);
                        } else if (widget.phoneController.text.isEmpty) {
                          callWarningDialog(
                              context, 'warning_dialog__input_phone'.tr);
                        } else {
                          await PsProgressDialog.showDialog(context);
                          await verifyPhone();
                        }
                      });
                });
          }),
    );
  }
}
