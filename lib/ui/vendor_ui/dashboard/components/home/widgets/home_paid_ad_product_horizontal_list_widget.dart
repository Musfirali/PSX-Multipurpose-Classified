import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/product/paid_ad_product_provider copy.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/product_list_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../custom_ui/item/list_item/product_horizontal_list_widget.dart';
import '../../../../common/ps_list_header_widget.dart';

class HomePaidAdProductHorizontalListWidget extends StatelessWidget {
  const HomePaidAdProductHorizontalListWidget({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = curveAnimation(animationController!);
    return SliverToBoxAdapter(
      child: Consumer<PaidAdProductProvider>(
        builder: (BuildContext context,
            PaidAdProductProvider paidAdItemProvider, Widget? child) {
          return AnimatedBuilder(
            animation: animationController!,
            child:
                (paidAdItemProvider.currentStatus == PsStatus.BLOCK_LOADING ||
                        paidAdItemProvider.hasData)
                    /**
                 * UI SECTION
                 */
                    ? Column(
                        children: <Widget>[
                          PsListHeaderWidget(
                            headerName: 'home__drawer_menu_feature_item'.tr,
                            headerDescription: '',
                            viewAllClicked: () {
                              viewAllFeaturedItemClick(context);
                            },
                          ),
                          CustomProductHorizontalListWidget(
                            tagKey: paidAdItemProvider.hashCode.toString(),
                            productList: paidAdItemProvider.productList.data,
                            isLoading: paidAdItemProvider.currentStatus ==
                                PsStatus.BLOCK_LOADING,
                          ),
                        ],
                      )
                    : Container(),
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
        },
      ),
    );
  }

  void viewAllFeaturedItemClick(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.filterProductList,
        arguments: ProductListIntentHolder(
            appBarTitle: 'home__drawer_menu_feature_item'.tr,
            productParameterHolder:
                ProductParameterHolder().getPaidItemParameterHolder()));
  }
}
