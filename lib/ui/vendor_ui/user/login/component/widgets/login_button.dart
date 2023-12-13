import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../common/dialog/warning_dialog_view.dart';
import '../../../../common/ps_button_widget.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {required this.emailController,
      required this.passwordController,
      required this.onProfileSelected,
      required this.callBackAfterLoginSuccess});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function? onProfileSelected, callBackAfterLoginSuccess;
  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    return Container(
      height: 40,
      margin: const EdgeInsets.only(
          top: PsDimens.space12,
          left: PsDimens.space16,
          right: PsDimens.space16),
      child: PSButtonWidget(
        colorData: Theme.of(context).primaryColor,
        hasShadow: false,
        width: double.infinity,
        titleText: 'login__sign_in'.tr,
        onPressed: () async {
          if (emailController.text.isEmpty) {
            callWarningDialog(context, 'warning_dialog__input_email'.tr);
          } else if (passwordController.text.isEmpty) {
            callWarningDialog(context, 'warning_dialog__input_password'.tr);
          } else {
            // if (Utils.checkEmailFormat(emailController.text.trim())!) {
              if (provider.isRememberMeChecked) {
                await provider.replaceUserInfo(emailController.text.trim(), passwordController.text); 
              }
              await provider.loginWithEmailId(
                  context,
                  emailController.text.trim() ,
                  passwordController.text,
                  onProfileSelected,
                  callBackAfterLoginSuccess,
                  langProvider!.currentLocale.languageCode);
            // } else {
            //   callWarningDialog(context, 'warning_dialog__email_format'.tr);
            // }
          }
        },
      ),
    );
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
