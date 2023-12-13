import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/forgot_password_parameter_holder.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../common/dialog/error_dialog.dart';
import '../../../../common/dialog/success_dialog.dart';

class ChangeEmailAndRecentCodeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final UserProvider provider = Provider.of<UserProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(PsDimens.space16),
          child: Text(
            'email_receive_verificatiion_code'.tr,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Utils.isLightMode(context)
                    ? PsColors.text800
                    : PsColors.achromatic50,
                fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: PsDimens.space12,
              right: PsDimens.space16,
              bottom: PsDimens.space12),
          child: InkWell(
              child: Ink(
                child: Text(
                  'email_verify__resent_code'.tr,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () async {
                if (await Utils.checkInternetConnectivity()) {
                  print(psValueHolder.userEmailToVerify);
                  final ForgotPasswordParameterHolder
                      resendCodeParameterHolder = ForgotPasswordParameterHolder(
                    userEmail: psValueHolder.userEmailToVerify,
                  );

                  final PsResource<ApiStatus> _apiStatus =
                      await provider.postForgotPassword(
                          resendCodeParameterHolder.toMap(),
                          langProvider!.currentLocale.languageCode);

                  if (_apiStatus.data != null) {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return SuccessDialog(
                            message: _apiStatus.data!.message,
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
              }),
        ),
      ],
    );
  }
}
