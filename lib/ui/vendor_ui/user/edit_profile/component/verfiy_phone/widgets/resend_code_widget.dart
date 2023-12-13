import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../common/dialog/error_dialog.dart';

class ResendCodeWidget extends StatefulWidget {
  const ResendCodeWidget({required this.userPhone});

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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        child: SizedBox(
          height: 40,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'email_verify__resent_code'.tr,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        onTap: () async {
          await PsProgressDialog.showDialog(context);
          await verifyPhone();
        },
      ),
    );
  }
}
