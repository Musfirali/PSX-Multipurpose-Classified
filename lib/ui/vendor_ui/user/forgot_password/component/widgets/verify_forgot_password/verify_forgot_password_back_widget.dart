import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class VerifyForgotPasswordBackWidget extends StatelessWidget {
  const VerifyForgotPasswordBackWidget({this.onToForgotPasswordSelected});

  final Function? onToForgotPasswordSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      child: InkWell(
          child: Center(
            child: Text(
              'phone_signin__back_login'.tr,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          onTap: () {
            if (onToForgotPasswordSelected != null) {
              onToForgotPasswordSelected!();
            } else {
              Navigator.pop(context);
            }
          }),
    );
  }
}
