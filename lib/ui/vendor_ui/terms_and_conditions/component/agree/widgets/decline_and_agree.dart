import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/about_us/about_us_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class AgreeTermsAndConditionDeclineAndAgreeWidget extends StatefulWidget {
  @override
  _AgreeTermsAndConditionDeclineAndAgreeWidgetState createState() {
    return _AgreeTermsAndConditionDeclineAndAgreeWidgetState();
  }
}

class _AgreeTermsAndConditionDeclineAndAgreeWidgetState
    extends State<AgreeTermsAndConditionDeclineAndAgreeWidget> {
  late AboutUsProvider aboutUsProvider;
  PsValueHolder? psValueHolder;

  @override
  Widget build(BuildContext context) {
    aboutUsProvider = Provider.of<AboutUsProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      child: InkWell(
        onTap: () {
          nextPage(true);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(PsDimens.space4),
          ),
          alignment: Alignment.center,
          height: 40,
          width: double.infinity,
          child: Text(
            'terms_and_conditions__agree'.tr,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Future<void> nextPage(bool intro) async {
    aboutUsProvider.replaceAgreeTermsAndConditions(intro);
    if (psValueHolder!.isForceLogin! &&
        Utils.checkUserLoginId(psValueHolder) == 'nologinuser') {
      Navigator.pushReplacementNamed(context, RoutePaths.login_container);
    } else if (psValueHolder!.isLanguageConfig! &&
        psValueHolder!.showOnboardLanguage) {
      Navigator.pushReplacementNamed(context, RoutePaths.languagesetting);
    } else {
      if (psValueHolder!.locationId != null) {
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
  }
}
