import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class ForgotPwdLoginTextWidget extends StatelessWidget {
  const ForgotPwdLoginTextWidget({this.goToLoginSelected});
  final Function? goToLoginSelected;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      height: 40,
      child: InkWell(
        onTap: () {
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
        child: Text(
          'forgot_psw__login'.tr,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Utils.isLightMode(context) ? PsColors.text900: PsColors.text50),
        ),
      ),
    );
  }
}
