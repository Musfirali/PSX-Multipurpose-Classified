import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class BackToLoginInVerifyWidget extends StatelessWidget {
  const BackToLoginInVerifyWidget({required this.onSignInSelected});
  final Function? onSignInSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      child: InkWell(
        onTap: () {
          if (onSignInSelected != null) {
            onSignInSelected!();
          } else {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
              context,
              RoutePaths.user_phone_signin_container,
            );
          }
        },
        child: Container(
          height: PsDimens.space40,
          child: Center(
            child: Text(
              'phone_signin__back_login'.tr,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
