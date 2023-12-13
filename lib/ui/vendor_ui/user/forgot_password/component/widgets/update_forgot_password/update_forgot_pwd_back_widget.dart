import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class UpdateForgotPasswordBackWidget extends StatelessWidget {
  const UpdateForgotPasswordBackWidget({this.goToVerifyPasswordSelected});

  final Function? goToVerifyPasswordSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      child: InkWell(
        onTap: () {
          if (goToVerifyPasswordSelected != null) {
            goToVerifyPasswordSelected!();
          } else {
            Navigator.pop(context);
          }
        },
        child: Center(
          child: Text(
            'phone_signin__back_login'.tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
