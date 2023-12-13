import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class PopularProductMenuWidget extends StatelessWidget {
  const PopularProductMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.inventory_2_outlined,
            size: 22,
            color: Utils.isLightMode(context)
                ? PsColors.achromatic800 : PsColors.achromatic50),
        minLeadingWidth: 0,
        title: Text(
          'home__drawer_menu_popular_item'.tr,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        onTap: () {
          Navigator.pop(context);
          if (updateSelectedIndexWithAnimation != null) {
            updateSelectedIndexWithAnimation!(
                'home__drawer_menu_popular_item'.tr,
                PsConst.REQUEST_CODE__MENU_TRENDING_PRODUCT_FRAGMENT);
          }
        });
  }
}
