import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../core/vendor/viewobject/holder/forgot_password_parameter_holder.dart';
import '../../../../common/dialog/email_sent_warning_dialog.dart';
import '../../../../common/dialog/error_dialog.dart';
import '../../../../common/dialog/warning_dialog_view.dart';
import '../../../../common/ps_button_widget.dart';

class ForgotPwdSendButton extends StatelessWidget {
  const ForgotPwdSendButton({
    required this.userEmailController,
    required this.goToLoginSelected,
    this.onVerifyForgotPasswordSelected,
  });

  final TextEditingController userEmailController;
  final Function? goToLoginSelected;
  final Function? onVerifyForgotPasswordSelected;

  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    return PSButtonWidget(
        colorData: Theme.of(context).primaryColor,
        hasShadow: false,
        width: double.infinity,
        titleText: 'email_verify__submit'.tr,
        onPressed: () async {
          if (userEmailController.text.isEmpty) {
            callWarningDialog(context, 'warning_dialog__input_email'.tr);
          } else {
            //if (Utils.checkEmailFormat(userEmailController.text.trim())!) {
              if (await Utils.checkInternetConnectivity()) {
                final ForgotPasswordParameterHolder
                    forgotPasswordParameterHolder =
                    ForgotPasswordParameterHolder(
                  userEmail: userEmailController.text.trim(),
                );

                await PsProgressDialog.showDialog(context);
                final PsResource<ApiStatus> _apiStatus =
                    await provider.postForgotPassword(
                        forgotPasswordParameterHolder.toMap(),
                        langProvider!.currentLocale.languageCode);
                PsProgressDialog.dismissDialog();

                if (_apiStatus.data != null) {
                  provider.psValueHolder!.userEmailToVerify =
                      userEmailController.text.trim();
                  callEmailSentWarningDialog(context);
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
            // } else {
            //   callWarningDialog(context, 'warning_dialog__email_format'.tr);
            // }
          }
        });
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

  dynamic callEmailSentWarningDialog(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return EmailSentWarningDialog(
            message: 'register__confirmation'.tr,
            onPressed: () async {
              Navigator.pop(context);
              if (onVerifyForgotPasswordSelected != null) {
                onVerifyForgotPasswordSelected!();
              } else {
                Navigator.pushNamed(
                    context, RoutePaths.verify_forgot_password_container,
                    arguments: userEmailController.text.trim());
              }
            },
          );
        });
  }
}
