import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/provider/product/added_item_provider.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/product.dart';
import '../../../../custom_ui/item/list_item/product_vertical_list_item.dart';
import '../../../common/ps_admob_native_widget.dart';

class UserItemList extends StatelessWidget {
  const UserItemList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final AddedItemProvider provider = Provider.of<AddedItemProvider>(context);
    final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count =
        isLoading ? valueHolder.loadingShimmerItemCount! : provider.dataLength;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 280.0,
          childAspectRatio: valueHolder.isShowOwnerInfo! ? 0.6 : 0.72),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (!isLoading &&
              provider.getListIndexOf(index).adType == PsConst.GOOGLE_AD_TYPE)
            return const PsAdMobNativeWidget();
          return CustomProductVeticalListItem(
            isLoading: isLoading,
            coreTagKey: provider.hashCode.toString(),
            product: isLoading ? Product() : provider.getListIndexOf(index),
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
