import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/ui/vendor_ui/setting/component/setting/widgets/setting_noti_switch_widget.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../custom_ui/setting/component/setting/widgets/setting_account_setting.dart';
import '../../../../custom_ui/setting/component/setting/widgets/setting_app_info.dart';
import '../../../../custom_ui/setting/component/setting/widgets/setting_app_version.dart';
import '../../../../custom_ui/setting/component/setting/widgets/setting_camera.dart';
import '../../../../custom_ui/setting/component/setting/widgets/setting_dark_white_mode.dart';
import '../../../../custom_ui/setting/component/setting/widgets/setting_faq.dart';
import '../../../../custom_ui/setting/component/setting/widgets/setting_introslider.dart';
import '../../../../custom_ui/setting/component/setting/widgets/setting_language_setting.dart';
import '../../../../custom_ui/setting/component/setting/widgets/setting_privacy.dart';
import '../../../../custom_ui/setting/component/setting/widgets/setting_terms_conditions.dart';
import '../../../../custom_ui/setting/component/setting/widgets/setting_title.dart';
import '../../../common/ps_admob_banner_widget.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;

  void checkConnection() {
    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
      if (isConnectedToInternet && valueHolder.isShowAdmob!) {
        // setState(() {});
      }
    });
  }

  late PsValueHolder valueHolder;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context);
    if (!isConnectedToInternet && valueHolder.isShowAdmob!) {
      print('loading ads....');
      checkConnection();
    }
    widget.animationController!.forward();
    final Animation<double> animation =
        curveAnimation(widget.animationController!);
    return AnimatedBuilder(
      animation: widget.animationController!,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CustomSettingTitleWidget(title: 'setting_configuration'.tr),
            if (!Utils.isLoginUserEmpty(valueHolder))
              CustomSettingAccountSettingWidget(),
            CustomSettingLanguageSettingWidget(),
            CustomSettingDarkAndWhiteModeWidget(
                animationController: widget.animationController),
            SettingNotiSwitchWidget(),
            CustomSettingCameraWidget(),
            CustomIntroSliderWidget(),
            const SizedBox(height: PsDimens.space2),
            CustomSettingTitleWidget(title: 'setting_about'.tr),
            CustomSettingTermsAndConditionsWidget(),
            CustomSettingPrivacyWidget(),
            CustomSettingFAQWidget(),
            // CustomSettingNotificationWidget(),
            CustomSettingAppInfoWidget(),
            CustomSettingAppVersionWidget(),
            const SizedBox(
              height: 20,
            ),
            const PsAdMobBannerWidget(
              admobSize: AdSize.mediumRectangle,
              // admobBannerSize: AdmobBannerSize.MEDIUM_RECTANGLE,
            ),
          ],
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 100 * (1.0 - animation.value), 0.0),
              child: child),
        );
      },
    );
  }
}
