import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/sold_out_item_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/item_list_intent_holder.dart';
import '../../../../../custom_ui/item/list_item/product_horizontal_list_widget.dart';
import '../../../../common/ps_list_header_widget.dart';

class SoldOutProductListWidget extends StatelessWidget {
  const SoldOutProductListWidget(
      {Key? key,
      required this.animationController})
      : super(key: key);

  final AnimationController? animationController;
  
  @override
  Widget build(BuildContext context) {
    final Animation<double>? animation = curveAnimation(animationController!);
    return SliverToBoxAdapter(child: Consumer<SoldOutItemProvider>(builder:
        (BuildContext context, SoldOutItemProvider productProvider,
            Widget? child) {
      return AnimatedBuilder(
          animation: animationController!,
          child: (productProvider.currentStatus == PsStatus.BLOCK_LOADING || 
                  productProvider.hasData)
              ? Column(children: <Widget>[
                  PsListHeaderWidget(
                    headerName: 'item_entry__sold_out'.tr,
                    viewAllClicked: () {
                      Navigator.pushNamed(
                          context, RoutePaths.userItemList,
                          arguments: ItemListIntentHolder(
                              userId:
                                  productProvider.psValueHolder!.loginUserId,
                              status: '1',
                              title: 'item_entry__sold_out'.tr,
                              isSoldOutList: true));
                    },
                  ),
                  CustomProductHorizontalListWidget(
                    isLoading: productProvider.currentStatus == PsStatus.BLOCK_LOADING,
                    productList: productProvider.itemList.data,
                    tagKey: productProvider.hashCode.toString(),
                  ),
                ])
              : const SizedBox(),
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