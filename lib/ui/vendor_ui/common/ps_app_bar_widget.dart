import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psxmpc/config/ps_colors.dart';
import '../../../core/vendor/utils/utils.dart';

class PsAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const PsAppbarWidget(
      {this.useSliver = false,
      this.appBarTitle,
      this.actionWidgets,
      this.leading});
  final bool useSliver;
  final String? appBarTitle;
  final List<Widget>? actionWidgets;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    if (useSliver)
      return SliverToBoxAdapter(
          child: _AppbarWidget(
        appBarTitle: appBarTitle,
        actionWidgets: actionWidgets,
        leading: leading,
      ));
    else
      return _AppbarWidget(
        appBarTitle: appBarTitle,
        actionWidgets: actionWidgets,
        leading: leading,
      );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppbarWidget extends StatelessWidget {
  const _AppbarWidget({this.appBarTitle, this.actionWidgets, this.leading});
  final String? appBarTitle;
  final List<Widget>? actionWidgets;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    // this is custom appbar with leading
    if (leading != null) {
      return AppBar(
        primary: false,
        titleSpacing: 0,
        leading: leading,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
        ),
        iconTheme:
            Theme.of(context).iconTheme,
        title: Text(appBarTitle ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Utils.isLightMode(context) ? PsColors.achromatic900 : PsColors.achromatic50, fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: actionWidgets,
      );
    } else {
      return AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
        ),
        iconTheme: Theme.of(context).iconTheme,
        title: Text(appBarTitle ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Utils.isLightMode(context) ? PsColors.achromatic900 : PsColors.achromatic50, fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: actionWidgets,
      );
    }
  }
}
