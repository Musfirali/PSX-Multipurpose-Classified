import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:theme_manager/theme_manager.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class SettingDarkAndWhiteModeWidget extends StatefulWidget {
  const SettingDarkAndWhiteModeWidget({Key? key, this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  __SettingDarkAndWhiteModeWidgetState createState() =>
      __SettingDarkAndWhiteModeWidgetState();
}

class __SettingDarkAndWhiteModeWidgetState
    extends State<SettingDarkAndWhiteModeWidget> {
  bool checkClick = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: PsDimens.space4),
      child: Padding(
          padding: const EdgeInsets.only(
              left: PsDimens.space16,
              right: PsDimens.space16,
              top: PsDimens.space12),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'setting__change_mode'.tr,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Utils.isLightMode(context)
                              ? PsColors.text800 : PsColors.text50,
                        ),
                  ),
                  //if (checkClick)
                  SizedBox(
                    width: 52,
                    height: 24,
                    child: Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value: !Utils.isLightMode(context),
                        onChanged: (bool value) {
                          // PsColors.loadColor2(value);
                          changeBrightness(context);
                        },
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Divider(
                  height: PsDimens.space2,
                ),
              ),
            ],
          )),
    );
  }

  void changeBrightness(BuildContext context) {
    ThemeManager.of(context).setBrightnessPreference(Utils.isLightMode(context)
        ? BrightnessPreference.dark
        : BrightnessPreference.light);
  }
}
