import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({required this.fromSettingSlider});
  final bool fromSettingSlider;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Padding(
      padding: const EdgeInsets.only(
          right: PsDimens.space16,
          top: PsDimens.space32,
          left: PsDimens.space16),
      child: InkWell(
          onTap: () {
            if (!psValueHolder.isAggreTermsAndConditions &&
                !fromSettingSlider) {
              Navigator.pushReplacementNamed(
                  context, RoutePaths.agreeTermsAndCondtion);
            } else if (fromSettingSlider) {
              Navigator.pop(context);
            } else if (psValueHolder.isForceLogin! &&
                Utils.checkUserLoginId(psValueHolder) == 'nologinuser') {
              Navigator.pushReplacementNamed(
                  context, RoutePaths.login_container);
            } else if (psValueHolder.isLanguageConfig! &&
                psValueHolder.showOnboardLanguage) {
              Navigator.pushReplacementNamed(
                  context, RoutePaths.languagesetting);
            } else if (psValueHolder.locationId != null) {
              Navigator.pushReplacementNamed(
                context,
                RoutePaths.home,
              );
            } else {
              Navigator.pushReplacementNamed(
                context,
                RoutePaths.itemLocationList,
              );
            }
          },
          child: Ink(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: PsDimens.space64,
                  child: Center(
                    child: Text(
                      'intro_slider_skip'.tr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
