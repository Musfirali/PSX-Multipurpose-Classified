import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/constant/ps_constants.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../custom_ui/noti/component/appbar_noti_icon.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({
    required this.appBarTitle,
    required this.appBarTitleName,
    required this.currentIndex,
  });
  final String appBarTitle;
  final String appBarTitleName;
  final int? currentIndex;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    final bool hideAppbar = (Utils.showFavoriteProduct(currentIndex) &&
            !Utils.isLoginUserEmpty(valueHolder)) ||
        Utils.showPopularProductView(currentIndex) ||
        Utils.showFeaturedProductView(currentIndex) ||
        Utils.showProfileView(currentIndex, valueHolder);

    if (hideAppbar) {
      return const SizedBox();
    }
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        appBarTitleName == '' ? appBarTitle : appBarTitleName,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold, color: Utils.isLightMode(context) ? PsColors.achromatic900 : PsColors.achromatic50),
      ),
      titleSpacing: 0,
      elevation: 0,
      iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor),
      titleTextStyle: const TextStyle(
          fontFamily: PsConst.ps_default_font_family,
          fontWeight: FontWeight.bold,
          fontSize: 18),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
      ),
      actions: Utils.showHomeDashboardView(currentIndex)
          ? <Widget>[
              IconButton(
                icon: const Icon(Icons.location_on_outlined),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RoutePaths.itemLocationList,
                  );
                },
              ),
              CustomAppbarNotiIcon(),
              const SizedBox(
                width: 8,
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
