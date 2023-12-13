import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/update_forgort_password_holder.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/dialog/success_dialog.dart';

class UpdateForgotPasswordSaveButton extends StatelessWidget {
  const UpdateForgotPasswordSaveButton(
      {required this.passwordController,
      required this.confirmPasswordController,
      required this.codeController,
      required this.userId,
      this.goToLoginSelected});

  final TextEditingController passwordController, confirmPasswordController,codeController;
  final String userId;
  final Function? goToLoginSelected;

  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
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
                          .copyWith(color: PsColors.achromatic50),
                    )
                  : Text(
                      'change_password__save'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: PsColors.achromatic50),
                    )
              : Text(
                  'login__sign_in'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: PsColors.achromatic50),
                ),
          onPressed: () async {
            if (passwordController.text != '' &&
                confirmPasswordController.text != '') {
              if (passwordController.text == confirmPasswordController.text) {
                if (await Utils.checkInternetConnectivity()) {
                  final UpdateForgotPasswordParameterHolder contactUsParameterHolder =
                      UpdateForgotPasswordParameterHolder(
                          userId: provider.psValueHolder!.loginUserId,
                          userPassword: passwordController.text,
                          confPassword: confirmPasswordController.text,
                          code: codeController.text);

                  final PsResource<ApiStatus> _apiStatus =
                      await provider.postUpdateForgotPassword(
                          contactUsParameterHolder.toMap(),
                          provider.psValueHolder!.loginUserId!,
                          langProvider!.currentLocale.languageCode);

                  if (_apiStatus.data != null) {
                    passwordController.clear();
                    confirmPasswordController.clear();

                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return SuccessDialog(
                            title: 'new_psw_create_done'.tr,
                            message: 'new_psw_created.tr',
                            btnTitle: 'login__sign_in'.tr,
                            onPressed: () {
                              if (goToLoginSelected != null) {
                                goToLoginSelected!();
                              } else {
                                if (psValueHolder.isForceLogin!) {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    RoutePaths.login_container,
                                  );
                                }
                              }
                            },
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
