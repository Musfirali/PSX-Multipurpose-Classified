import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../../config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/ps_animation.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../custom_ui/activity_log/component/widget/block_user_widget.dart';
import '../../../custom_ui/activity_log/component/widget/browse_history_widget.dart';
import '../../../custom_ui/activity_log/component/widget/favourite_history_widget.dart';
import '../../../custom_ui/activity_log/component/widget/follower_widget.dart';
import '../../../custom_ui/activity_log/component/widget/following_widget.dart';
import '../../../custom_ui/activity_log/component/widget/package_history_widget.dart';
import '../../../custom_ui/activity_log/component/widget/promotion_history_widget.dart';
import '../../../custom_ui/activity_log/component/widget/search_history_widget.dart';
import '../../common/ps_admob_banner_widget.dart';

class ActivityLogView extends StatefulWidget {
  const ActivityLogView(
      {Key? key, required this.scaffoldKey, required this.animationController})
      : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final AnimationController? animationController;
  @override
  _ActivityLogViewState createState() => _ActivityLogViewState();
}

class _ActivityLogViewState extends State<ActivityLogView> {

  late PsValueHolder valueHolder;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);
    final Widget _dividerWidget = Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14),
      child: Divider(
        height: PsDimens.space2,
        color: Utils.isLightMode(context) ? PsColors.achromatic300 : PsColors.achromatic400,
      ),
    );

    widget.animationController!.forward();
    final Animation<double> animation =
        curveAnimation(widget.animationController!);
    return Scaffold(
        body: AnimatedBuilder(
          animation: widget.animationController!,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CustomBrowseHistoryWidget(),
                _dividerWidget,
                if (valueHolder.isPaidApp == PsConst.ONE)
                  CustomPackageHistoryWidget(),
                if (valueHolder.isPaidApp == PsConst.ONE)  
                _dividerWidget,
                CustomPromotionHistoryWidget(),
                _dividerWidget,
                CustomSearchHistoryWidget(),
                _dividerWidget,
                CustomFavouriteHistoryWidget(),
                _dividerWidget,
                CustomFollowerWidget(),
                _dividerWidget,
                CustomFollowingWidget(),
                _dividerWidget,
                CustomBlockUserWidget(),
                _dividerWidget,
                const PsAdMobBannerWidget(
                  admobSize: AdSize.mediumRectangle,
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
        ));
  }
}
