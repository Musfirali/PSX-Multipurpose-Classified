import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../common/dialog/error_dialog.dart';

class ResendCodeWidget extends StatefulWidget {
  const ResendCodeWidget(
      {required this.onSignInSelected,
      required this.userName,
      required this.userPhone});

  final Function? onSignInSelected;
  final String userName;
  final String userPhone;

  @override
  __ResendCodeWidgetState createState() => __ResendCodeWidgetState();
}

class __ResendCodeWidgetState extends State<ResendCodeWidget> {
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

      // if (widget.onSignInSelected != null) {
      //   widget.onSignInSelected!(
      //       widget.userName, widget.userPhone, verificationId);
      // }
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
        phoneNumber: widget.userPhone,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(minutes: 2),
        verificationCompleted: verifySuccess,
        verificationFailed: verifyFail);
    return verificationId;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'phone_receive_otp_code'.tr,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Utils.isLightMode(context)
                    ? PsColors.text800
                    : PsColors.achromatic50),
          ),
          InkWell(
            child: Ink(
              child: Text(
                'email_verify__resent_code'.tr,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            onTap: () async {
              await PsProgressDialog.showDialog(context);
              await verifyPhone();
            },
          ),
        ],
      ),
    );
  }
}
