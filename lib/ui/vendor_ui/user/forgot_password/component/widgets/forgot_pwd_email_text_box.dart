import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../config/ps_colors.dart';

class ForgotPwdEmailTextBox extends StatelessWidget {
  const ForgotPwdEmailTextBox({
    required this.userEmailController,
  });

  final TextEditingController userEmailController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: userEmailController,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: PsColors.text400),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: PsColors.text400),
          ),
          hintText: 'forgot_psw__email'.tr,
          hintStyle: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: PsColors.text400),
        ),
      ),
    );
  }
}
