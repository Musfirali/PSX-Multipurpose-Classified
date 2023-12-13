import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/product/added_item_provider.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/product.dart';
import '../../../../custom_ui/item/list_item/product_vertical_list_item.dart';

class OtherUserProductList extends StatelessWidget {
  const OtherUserProductList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final AddedItemProvider addedItemProvider =
        Provider.of<AddedItemProvider>(context);
    final bool isLoading =
        addedItemProvider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count = isLoading
        ? valueHolder.loadingShimmerItemCount!
        : addedItemProvider.dataLength;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 280.0,
          childAspectRatio: valueHolder.isShowOwnerInfo! ? 0.6 : 0.72),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CustomProductVeticalListItem(
            isLoading: isLoading,
            coreTagKey: addedItemProvider.hashCode.toString(),
            product:
                isLoading ? Product() : addedItemProvider.getListIndexOf(index),
            animation:
                curveAnimation(animationController, index: index, count: count),
            animationController: animationController,
          );
        },
        childCount: count,
      ),
    );
  }
}
