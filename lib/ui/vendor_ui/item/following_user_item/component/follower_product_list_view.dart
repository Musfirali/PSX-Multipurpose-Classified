import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/provider/product/item_list_from_followers_provider.dart';
import '../../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../custom_ui/item/list_item/product_vertical_list_item.dart';

class FollwerProductList extends StatelessWidget {
  const FollwerProductList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final ItemListFromFollowersProvider provider =
        Provider.of<ItemListFromFollowersProvider>(context);
    final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count =
        isLoading ? valueHolder.loadingShimmerItemCount! : provider.dataLength;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 280.0,
          childAspectRatio: valueHolder.isShowOwnerInfo! ? 0.6 : 0.72),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CustomProductVeticalListItem(
            isLoading: isLoading,
            coreTagKey: provider.hashCode.toString(),
            product: isLoading ? Product() : provider.getListIndexOf(index),
            onTap: () async {
              await provider.loadDataList(reset: true);
            },
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
