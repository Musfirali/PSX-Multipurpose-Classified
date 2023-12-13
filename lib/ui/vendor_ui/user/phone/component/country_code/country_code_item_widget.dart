import 'package:flutter/material.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/viewobject/phone_country_code.dart';

class CountryCodeItemWidget extends StatelessWidget {
  const CountryCodeItemWidget(
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
    animationController!.forward();
    return AnimatedBuilder(
      animation: animationController!,
      child: InkWell (
      onTap: onTap as Function(),
      child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(
                PsDimens.space16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    phoneCountryCode.countryName!,
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  Text(
                    phoneCountryCode.countryCode!,
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                ],
              ),
            ),
            Container(
              child: const Divider(
                height: PsDimens.space2,
              ),
            ),
          ])
        ),
        builder: (BuildContext contenxt, Widget? child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 100 * (1.0 - animation!.value), 0.0),
              child: child,
            ),
          );
        },
      );
    }
  }