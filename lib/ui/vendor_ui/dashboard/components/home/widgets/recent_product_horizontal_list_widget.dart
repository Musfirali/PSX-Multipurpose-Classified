import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/product/recent_product_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/product_list_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../custom_ui/item/list_item/product_horizontal_list_widget.dart';
import '../../../../common/ps_admob_banner_widget.dart';
import '../../../../common/ps_list_header_widget.dart';

class RecentProductHorizontalListWidget extends StatelessWidget {
  const RecentProductHorizontalListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = curveAnimation(animationController!);
    return SliverToBoxAdapter(child: Consumer<RecentProductProvider>(builder:
        (BuildContext context, RecentProductProvider productProvider,
            Widget? child) {
      // print('status:::::::${productProvider.currentStatus}');
      return AnimatedBuilder(
          animation: animationController!,
          child: (productProvider.currentStatus == PsStatus.BLOCK_LOADING ||
                  productProvider.hasData)
              /**
              * UI SECTION
              */
              ? Column(children: <Widget>[
                  PsListHeaderWidget(
                    headerName: 'dashboard_recent_product'.tr,
                    headerDescription: '',
                    viewAllClicked: () {
                      viewAllRecentClicked(context);
                    },
                  ),
                  CustomProductHorizontalListWidget(
                    tagKey: productProvider.hashCode.toString(),
                    productList: productProvider.productList.data,
                    isLoading:
                        productProvider.currentStatus == PsStatus.BLOCK_LOADING,
                  ),
                  const PsAdMobBannerWidget(
                    admobSize: AdSize.mediumRectangle,
                  ),
                ])
              : const SizedBox(),
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
                opacity: animation,
                child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 100 * (1.0 - animation.value), 0.0),
                    child: child));
          });
    }));
  }

  void viewAllRecentClicked(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.filterProductList,
        arguments: ProductListIntentHolder(
            appBarTitle: 'dashboard_recent_product'.tr,
            productParameterHolder:
                ProductParameterHolder().getRecentParameterHolder()));
  }
}
