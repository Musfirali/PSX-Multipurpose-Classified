import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/disabled_product_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/item_list_intent_holder.dart';
import '../../../../../custom_ui/item/list_item/product_horizontal_list_widget.dart';
import '../../../../common/ps_list_header_widget.dart';

class DisabledListingDataWidget extends StatelessWidget {
  const DisabledListingDataWidget(
      {Key? key,
      required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    final Animation<double>? animation = curveAnimation(animationController!);
    return SliverToBoxAdapter(
      child: Consumer<DisabledProductProvider>(builder:
        (BuildContext context, DisabledProductProvider itemProvider,
            Widget? child) {
      return AnimatedBuilder(
          animation: animationController!,
          child: (itemProvider.hasData || itemProvider.currentStatus == PsStatus.BLOCK_LOADING)
              ? Column(children: <Widget>[
                  PsListHeaderWidget(
                    headerName: 'profile__disable_listing'.tr,
                    viewAllClicked: () {
                      Navigator.pushNamed(
                          context, RoutePaths.userItemList,
                          arguments: ItemListIntentHolder(
                              userId: itemProvider.psValueHolder!.loginUserId,
                              status: '2',
                              title: 'profile__disable_listing'.tr));
                    },
                  ),
                  CustomProductHorizontalListWidget(
                    tagKey: itemProvider.hashCode.toString(),
                    productList: itemProvider.itemList.data,
                    isLoading: itemProvider.currentStatus == PsStatus.BLOCK_LOADING)
                ])
              : Container(),
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
                opacity: animation!,
                child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 100 * (1.0 - animation.value), 0.0),
                    child: child));
          });
    }));
  }
}
