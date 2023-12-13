import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class LoginPasswordTextBox extends StatefulWidget {
  const LoginPasswordTextBox({required this.passwordController});
  final TextEditingController passwordController;

  @override
  State<LoginPasswordTextBox> createState() => _LoginPasswordTextBoxState();
}

class _LoginPasswordTextBoxState extends State<LoginPasswordTextBox> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    if (psValueHolder.userPassword != '') {
      widget.passwordController.text = psValueHolder.userPassword!;
    }
    return Container(
      margin: const EdgeInsets.only(
          top: PsDimens.space8,
          left: PsDimens.space16,
          right: PsDimens.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Password'.tr,
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
              controller: widget.passwordController,
              obscureText: !passwordVisible,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(),
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
                // decoration: InputDecoration(
                //   contentPadding:
                //       const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                //   border: OutlineInputBorder(
                //     borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                //     borderSide:
                //         BorderSide(color: PsColors.text400, width: 5.0),
                //   ),
                hintText: 'login__password'.tr,
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: PsColors.text400),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: PsColors.achromatic500,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
              // keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
