import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../common/dialog/warning_dialog_view.dart';
import '../../../../common/ps_button_widget.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton(
      {required this.nameTextEditingController,
      required this.emailTextEditingController,
      required this.userNameTextEditingController,
      required this.passwordTextEditingController,
      this.onRegisterSelected, 
      required this.callBackAfterLoginSuccess});
  final Function? onRegisterSelected, callBackAfterLoginSuccess;
  final TextEditingController? nameTextEditingController,userNameTextEditingController,
      emailTextEditingController,
      passwordTextEditingController;

  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    return Container(
      height: 40,
      margin: const EdgeInsets.only(
          left: PsDimens.space16, 
          right: PsDimens.space16),
      child: PSButtonWidget(
        colorData: Theme.of(context).primaryColor,
        hasShadow: false,
        width: double.infinity,
        titleText: 'register__register'.tr,
        onPressed: () async {
          if (nameTextEditingController!.text.isEmpty) {
            callWarningDialog(context, 'warning_dialog__input_name'.tr);
          } else if (emailTextEditingController!.text.isEmpty) {
            callWarningDialog(context, 'warning_dialog__input_email'.tr);
          } else if (passwordTextEditingController!.text.isEmpty) {
            callWarningDialog(context, 'warning_dialog__input_password'.tr);
          } else if (passwordTextEditingController!.text.length < 6) {
            callWarningDialog(context, 'password_less_than_warning'.tr);
          } else {
            if (Utils.checkEmailFormat(
                emailTextEditingController!.text.trim())!) {
              await provider.signUpWithEmailId(
                  context,
                  onRegisterSelected,
                  nameTextEditingController!.text,
                  userNameTextEditingController!.text,
                  emailTextEditingController!.text.trim(),
                  passwordTextEditingController!.text,
                  callBackAfterLoginSuccess,
                  langProvider!.currentLocale.languageCode);
            } else {
              callWarningDialog(context, 'warning_dialog__email_format'.tr);
            }
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
