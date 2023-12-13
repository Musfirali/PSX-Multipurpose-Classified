import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class ForgotPasswordTextWidget extends StatelessWidget {
  const ForgotPasswordTextWidget({
    Key? key,
    this.onForgotPasswordSelected,
  }) : super(key: key);

  final Function? onForgotPasswordSelected;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Container(
        padding: const EdgeInsets.only(bottom: PsDimens.space4),
        margin: const EdgeInsets.only(top: PsDimens.space12),
        child: InkWell(
            onTap: () {
              if (onForgotPasswordSelected != null) {
                onForgotPasswordSelected!();
              } else {
                if (psValueHolder.isForceLogin!) {
                  Navigator.pushNamed(
                    context,
                    RoutePaths.user_forgot_password_container,
                  );
                } else {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutePaths.user_forgot_password_container,
                  );
                }
              }
            },
            child: Text('login__forgot_password'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ))));
  }
}
