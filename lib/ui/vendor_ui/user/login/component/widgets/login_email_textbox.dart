import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class LoginEmailTextBox extends StatelessWidget {
  const LoginEmailTextBox({required this.emailController});
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    if (psValueHolder.userEmail != '') {
      emailController.text = psValueHolder.userEmail!;
    }
    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space16, right: PsDimens.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'login_username_email_phone'.tr,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Utils.isLightMode(context)
                      ? PsColors.text800
                      : PsColors.achromatic50),
            ),
          ),
          SizedBox(
            height: 40,
            child: TextField(
              controller: emailController,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.0, color: PsColors.text400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.0, color: PsColors.text400),
                ),
                hintText: 'login_username_email_phone_hint'.tr,
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: PsColors.text400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
