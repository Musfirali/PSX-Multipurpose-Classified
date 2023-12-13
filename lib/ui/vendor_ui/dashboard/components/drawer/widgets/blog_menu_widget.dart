import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class BlogMenuWidget extends StatelessWidget {
  const BlogMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.newspaper,
            size: 22,
            color: Utils.isLightMode(context)
                ? PsColors.achromatic800 : PsColors.achromatic50),
        minLeadingWidth: 0,
        title: Text(
          'home__menu_drawer_blog'.tr,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        onTap: () {
          Navigator.pop(context);
          if (updateSelectedIndexWithAnimation != null) {
            updateSelectedIndexWithAnimation!('home__menu_drawer_blog'.tr,
                PsConst.REQUEST_CODE__MENU_BLOG_FRAGMENT);
          }
        });
  }
}
