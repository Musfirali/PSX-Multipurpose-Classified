import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class IntroSliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: PsDimens.space4),
      child: InkWell(
        onTap: () {
          print('Slider Guide');
          Navigator.pushNamed(context, RoutePaths.introSlider, arguments: true);
        },
        child: Padding(
          padding: const EdgeInsets.only(
              left: PsDimens.space16,
              right: PsDimens.space16,
              top: PsDimens.space12),
          child: Column(
            children: <Widget>[
              Ink(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'intro_slider_setting'.tr,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text800 : PsColors.text50,
                                  ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Icon(
                        Icons.chevron_right,
                        color: Utils.isLightMode(context)
                            ? PsColors.text800 : PsColors.text50,
                        size: PsDimens.space20,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Divider(
                  height: PsDimens.space2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
