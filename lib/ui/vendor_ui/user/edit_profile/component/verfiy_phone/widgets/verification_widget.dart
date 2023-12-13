import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/viewobject/edit_profile_user_relation.dart';

import '../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/holder/profile_update_view_holder.dart';
import '../../../../../../../core/vendor/viewobject/user.dart' as obj;
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/dialog/success_dialog.dart';
import '../../../../../common/dialog/warning_dialog_view.dart';
import '../../../../../common/ps_button_widget.dart';
import '../../../../../common/ps_email_textfield_widget.dart';

class VerificationWidget extends StatefulWidget {
  const VerificationWidget({
    required this.phoneNumber,
    required this.phoneId,
  });

  final String phoneNumber;
  final String? phoneId;

  @override
  __TextFieldAndButtonWidgetState createState() =>
      __TextFieldAndButtonWidgetState();
}

class __TextFieldAndButtonWidgetState extends State<VerificationWidget> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController userIdTextField = TextEditingController();
  late UserProvider provider;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);
    langProvider = Provider.of<AppLocalization>(context);
    return Column(
      children: <Widget>[
        PsEmailTextFieldWidget(
          textEditingController: codeController,
          hintText: 'phone_otp_hint'.tr,
        ),
        const SizedBox(
          height: PsDimens.space16,
        ),
        Container(
          margin: const EdgeInsets.only(
              left: PsDimens.space16, right: PsDimens.space16),
          child: PSButtonWidget(
            colorData: Theme.of(context).primaryColor,
            hasShadow: true,
            width: double.infinity,
            titleText: 'email_verify__submit'.tr,
            onPressed: () async {
              if (codeController.text.isEmpty) {
                callWarningDialog(context, 'warning_dialog__code_require'.tr);
              } else if (codeController.text.length != 6) {
                callWarningDialog(context, 'Verification OTP code is wrong');
              } else {
                final fb_auth.User? user =
                    fb_auth.FirebaseAuth.instance.currentUser;

                if (user != null) {
                  print('correct code');
                  callApi(provider, user, langProvider, widget.phoneNumber,
                      context);
                } else {
                  final fb_auth.AuthCredential credential =
                      fb_auth.PhoneAuthProvider.credential(
                          verificationId: widget.phoneId!,
                          smsCode: codeController.text);

                  try {
                    await fb_auth.FirebaseAuth.instance
                        .signInWithCredential(credential)
                        .then((fb_auth.UserCredential user) async {
                      print('correct code again');
                      callApi(provider, user.user, langProvider,
                          widget.phoneNumber, context);
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
            },
          ),
        )
      ],
    );
  }

  dynamic callApi(
      UserProvider userProvider,
      fb_auth.User? user,
      AppLocalization langProvider,
      String phoneNmuber,
      BuildContext context) async {
    if (await Utils.checkInternetConnectivity()) {
      final ProfileUpdateParameterHolder profileUpdateParameterHolder =
          ProfileUpdateParameterHolder(
              userId: userProvider.user.data!.userId,
              userName: userProvider.user.data!.name!.isEmpty
                  ? '-'
                  : userProvider.user.data!.name,
              userEmail: userProvider.user.data!.userEmail!.isEmpty
                  ? 'default@gmail.com'
                  : userProvider.user.data!.userEmail,
              userPhone: phoneNmuber,
              userAboutMe: userProvider.user.data!.userAboutMe!.isEmpty
                  ? '-'
                  : userProvider.user.data!.userAboutMe,
              isShowEmail: userProvider.user.data!.isShowEmail,
              isShowPhone: userProvider.user.data!.isShowPhone,
              userRelation: <EditProfileUserRelation>[]);
      await PsProgressDialog.showDialog(context);
      final PsResource<obj.User> _apiStatus =
          await userProvider.postProfileUpdate(
              profileUpdateParameterHolder.toMap(),
              userProvider.psValueHolder!.loginUserId!,
              langProvider.currentLocale.languageCode);
      if (_apiStatus.data != null) {
        // progressDialog.dismiss();
        PsProgressDialog.dismissDialog();
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext contet) {
              return SuccessDialog(
                message: 'edit_profile__success'.tr,
                onPressed: () {
                  Navigator.pop(context, phoneNmuber);
                },
              );
            });
      } else {
        PsProgressDialog.dismissDialog();

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
}
