import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/language_provider.dart';
import '../../../../core/vendor/repository/language_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../custom_ui/language/component/onboard_language/choose_language_dropdown_widget.dart';
import '../../common/base/ps_widget_with_appbar_no_app_bar_title.dart';
import '../../common/dialog/confirm_dialog_view.dart';

class OnBoardLanguageContainerView extends StatefulWidget {
  @override
  _LanguageSettingContainerViewState createState() =>
      _LanguageSettingContainerViewState();
}

class _LanguageSettingContainerViewState
    extends State<OnBoardLanguageContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    Future<bool> _requestPop() {
      if (valueHolder.isLanguageConfig!) {
        return showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ConfirmDialogView(
                  title: 'Confirm'.tr,
                  description: 'home__quit_dialog_description'.tr,
                  leftButtonText: 'dialog__cancel'.tr,
                  rightButtonText: 'dialog__ok'.tr,
                  onAgreeTap: () {
                    Navigator.pop(context, true);
                  });
            }).then((dynamic value) {
          if (value) {
            SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
          }
          return value;
        });
      } else {
        animationController!.reverse().then<dynamic>(
          (void data) {
            if (!mounted) {
              return Future<bool>.value(false);
            }
            Navigator.pop(context, true);
            return Future<bool>.value(true);
          },
        );
        return Future<bool>.value(false);
      }
    }

    print(
        '............................Build UI Again ............................');

    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBarNoAppBarTitle<LanguageProvider>(
        initProvider: () {
          return LanguageProvider(
              repo: Provider.of<LanguageRepository>(context));
        },
        onProviderReady: (LanguageProvider provider) {},
        builder:
            (BuildContext context, LanguageProvider provider, Widget? child) {
          provider.replaceShowOnboardLanguage(false);
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: PsDimens.space32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color:  Utils.isLightMode(context) ? PsColors.text800: PsColors.text50,
                        ),
                        onPressed: onClose,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: PsDimens.space104,
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: PsDimens.space64, bottom: PsDimens.space32),
                  child: SvgPicture.asset(
                    'assets/images/onboard_language.svg',
                  ),
                ),
                Text('language_selection__choose'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
                CustomChooseLanguageDropDownWidget(),
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.all(PsDimens.space16),
                    height: PsDimens.space40,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(PsDimens.space4),
                    ),
                    child: Text('language_selection__next'.tr,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800)),
                  ),
                  onTap: onClose,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void onClose() {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    if (psValueHolder.locationId != null) {
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
  }
}
