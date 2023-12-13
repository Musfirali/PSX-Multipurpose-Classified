import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class ExploreButton extends StatelessWidget {
  const ExploreButton({required this.fromSettingSlider});
  final bool fromSettingSlider;
  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: MaterialButton(
        height: 40,
        minWidth: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Text(
          'intro_slider_lets_explore'.tr,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        onPressed: () async {
          if (provider.isCheckBoxSelect) {
            await provider.replaceIsToShowIntroSlider(false);
          } else {
            await provider.replaceIsToShowIntroSlider(true);
          }

          if (!psValueHolder.isAggreTermsAndConditions && !fromSettingSlider) {
            Navigator.pushReplacementNamed(
                context, RoutePaths.agreeTermsAndCondtion);
          } else if (fromSettingSlider) {
            Navigator.pop(context);
          } else if (psValueHolder.isForceLogin! &&
              Utils.checkUserLoginId(psValueHolder) == 'nologinuser') {
            Navigator.pushReplacementNamed(context, RoutePaths.login_container);
          } else if (psValueHolder.isLanguageConfig! &&
              psValueHolder.showOnboardLanguage) {
            Navigator.pushReplacementNamed(context, RoutePaths.languagesetting);
          } else {
            if (psValueHolder.locationId != null) {
              Navigator.pushNamed(
                context,
                RoutePaths.home,
              );
            } else {
              Navigator.pushNamed(
                context,
                RoutePaths.itemLocationList,
              );
            }
          }
        },
      ),
    );
  }
}
