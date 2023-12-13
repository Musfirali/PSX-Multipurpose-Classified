import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/user.dart';


class GoToRegisterTextWidget extends StatelessWidget {
  const GoToRegisterTextWidget({Key? key, this.onSignInSelected})
      : super(key: key);

  final Function? onSignInSelected;

  @override
  Widget build(BuildContext context) {
    final UserProvider? provider = Provider.of<UserProvider>(context);
    return Container(
        margin: const EdgeInsets.only(
          left: PsDimens.space16,
          right: PsDimens.space16,
          bottom: PsDimens.space48,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () {
                onTap(context, provider);
              },
              child: Text("Don't have an account?".tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Utils.isLightMode(context)
                          ? PsColors.text500
                          : PsColors.achromatic50)),
            ),
            InkWell(
              onTap: () {
                onTap(context, provider);
              },
              child: Text('login__sign_up'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500)),
            ),
          ],
        ));
  }

  Future<void> onTap(BuildContext context, UserProvider? provider) async {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    if (onSignInSelected != null) {
      onSignInSelected!();
    } else {
      dynamic returnData;
      if (psValueHolder.isForceLogin!) {
        await Navigator.pushNamed(
          context,
          RoutePaths.user_register_container,
        );
      } else {
        await Navigator.pushReplacementNamed(
          context,
          RoutePaths.user_register_container,
        );
      }

      if (returnData is User) {
        final User user = returnData;
        provider!.psValueHolder =
            Provider.of<PsValueHolder>(context, listen: false);
        provider.psValueHolder!.loginUserId = user.userId;
        provider.psValueHolder!.userIdToVerify = '';
        provider.psValueHolder!.userNameToVerify = '';
        provider.psValueHolder!.userEmailToVerify = '';
        provider.psValueHolder!.userPasswordToVerify = '';
        Navigator.pop(context, user);
      }
    }
  }
}
