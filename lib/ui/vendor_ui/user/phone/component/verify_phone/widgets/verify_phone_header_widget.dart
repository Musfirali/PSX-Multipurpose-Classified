import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class VerifyPhoneHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget _textWidget = Text(
      'phone_signin__otp'.tr,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Utils.isLightMode(context)
              ? PsColors.text800
              : PsColors.achromatic50,
          fontWeight: FontWeight.w600),
    );

    final Widget _imageWidget = Container(
      width: 50,
      height: 50,
      child: Image.asset(
        'assets/images/flutter_buy_and_sell_logo.png',
      ),
    );
    return Column(
      children: <Widget>[
        const SizedBox(
          height: PsDimens.space32,
        ),
        _imageWidget,
        const SizedBox(
          height: PsDimens.space16,
        ),
        _textWidget,
      ],
    );
  }
}
