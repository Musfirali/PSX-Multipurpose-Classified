import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/phone_country_code.dart';
import '../../../../../vendor_ui/user/phone/component/country_code/country_code_item_widget.dart';

class CustomCountryCodeItemWidget extends StatelessWidget {
  const CustomCountryCodeItemWidget(
    {Key? key,
      required this.phoneCountryCode,
      this.onTap,
      this.animationController,
      this.animation})
    : super(key: key);

  final PhoneCountryCode phoneCountryCode;
  final Function? onTap;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return CountryCodeItemWidget(
      phoneCountryCode: phoneCountryCode,
      onTap: onTap,
      animationController: animationController,
      animation: animation
    );
  }
}