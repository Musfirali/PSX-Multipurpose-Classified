import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../common/ps_button_widget_with_round_corner.dart';

class GoToPackageShopView extends StatefulWidget {
  @override
  State<GoToPackageShopView> createState() => _GoToPackageShopViewState();
}

class _GoToPackageShopViewState extends State<GoToPackageShopView> {
  UserProvider? userProvider;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder? valueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);
    userProvider = Provider.of<UserProvider>(context);
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12, top: 60, bottom: 15),
            child: SvgPicture.asset('assets/images/buy_package.svg',
                width: double.infinity, height: 200),
          ),
          const SizedBox(height: PsDimens.space16),
          Text('Purchase the package first'.tr,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic900
                      : Utils.isLightMode(context) ? PsColors.text300: PsColors.text50,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          const SizedBox(height: PsDimens.space8),
          Text('You have to purchase the package to upload your items'.tr,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: PsColors.achromatic500,
                  )),
          Container(
            margin: const EdgeInsets.all(16.0),
            child: PSButtonWidgetRoundCorner(
              colorData: Theme.of(context).primaryColor,
              hasShadow: false,
              width: double.infinity,
              titleText: 'item_entry__package_go_to_shop'.tr,
              onPressed: () async {
                final dynamic returnData = await Navigator.pushNamed(
                    context, RoutePaths.buyPackage,
                    arguments: <String, dynamic>{
                      'android': valueHolder!.packageAndroidKeyList,
                      'ios': valueHolder.packageIOSKeyList
                    });

                if (returnData != null) {
                  setState(() {
                    userProvider!.user.data!.remainingPost = returnData;
                  });
                } else {
                  userProvider!.getUser(valueHolder.loginUserId,
                      langProvider.currentLocale.languageCode);
                }
              },
            ),
          ),
          const SizedBox(height: PsDimens.space80),
        ]);
  }
}
