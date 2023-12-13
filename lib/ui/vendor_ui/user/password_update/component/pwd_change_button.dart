import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../core/vendor/viewobject/holder/change_password_holder.dart';
import '../../../common/dialog/error_dialog.dart';
import '../../../common/dialog/success_dialog.dart';

class PwdChangeSaveButton extends StatelessWidget {
  const PwdChangeSaveButton({
    required this.oldPasswordController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController oldPasswordController,passwordController, confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(PsDimens.space16),
      child: MaterialButton(
          color: Theme.of(context).primaryColor,
          textColor: PsColors.achromatic50,
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          // ignore: unnecessary_null_comparison
          child: provider != null
              ? provider.isLoading
                  ? Text(
                      'login__loading'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic50: PsColors.text800),
                    )
                  : Text(
                      'change_password__save'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic50: PsColors.text800),
                    )
              : Text(
                  'login__sign_in'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic50: PsColors.text800),
                ),
          onPressed: () async {
            if (passwordController.text != '' &&
                confirmPasswordController.text != '') {
              if (passwordController.text == confirmPasswordController.text) {
                if (await Utils.checkInternetConnectivity()) {
                  final ChangePasswordParameterHolder contactUsParameterHolder =
                      ChangePasswordParameterHolder(
                          userId: provider.psValueHolder!.loginUserId,
                          userPassword: passwordController.text,
                          confPassword: confirmPasswordController.text,
                          oldPassword: oldPasswordController.text
                          );

                  final PsResource<ApiStatus> _apiStatus =
                      await provider.postChangePassword(
                          contactUsParameterHolder.toMap(),
                          provider.psValueHolder!.loginUserId!,
                          langProvider!.currentLocale.languageCode);

                  if (_apiStatus.data != null) {
                    passwordController.clear();
                    confirmPasswordController.clear();
                    oldPasswordController.clear();

                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return SuccessDialog(
                            message: _apiStatus.data!.status,
                            onPressed: () {},
                          );
                        });
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
              } else {
                showDialog<dynamic>(
                    context: context,
                    builder: (BuildContext context) {
                      return ErrorDialog(
                        message: 'change_password__not_equal'.tr,
                      );
                    });
              }
            } else {
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorDialog(
                      message: 'change_password__error'.tr,
                    );
                  });
            }
          }),
    );
  }
}
