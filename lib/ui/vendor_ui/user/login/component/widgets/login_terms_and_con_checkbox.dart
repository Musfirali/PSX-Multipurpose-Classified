import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class LoginTermsAndConCheckbox extends StatefulWidget {
  @override
  __TermsAndConCheckboxState createState() => __TermsAndConCheckboxState();
}

class __TermsAndConCheckboxState extends State<LoginTermsAndConCheckbox> {
  late UserProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);
    return Row(
      children: <Widget>[
        const SizedBox(
          width: PsDimens.space20,
        ),
        Checkbox(
          side: BorderSide(color: PsColors.primary500),
          checkColor: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
          activeColor: Theme.of(context).primaryColor,
          value: provider.isCheckBoxSelect,
          onChanged: (bool? value) {
            setState(() {
              updateCheckBox(context);
            });
          },
        ),
        Expanded(
          child: InkWell(
            child: Text(
              'login__agree_privacy'.tr,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic900
                      : PsColors.achromatic50),
            ),
            onTap: () {
              setState(() {
                updateCheckBox(context);
              });
            },
          ),
        ),
      ],
    );
  }

  void updateCheckBox(BuildContext context) {
    if (provider.isCheckBoxSelect) {
      provider.isCheckBoxSelect = false;
    } else {
      provider.isCheckBoxSelect = true;

      Navigator.pushNamed(context, RoutePaths.privacyPolicy);
    }
  }
}
