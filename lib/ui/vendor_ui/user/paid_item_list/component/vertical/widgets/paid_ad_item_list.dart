import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../../core/vendor/provider/product/paid_id_item_provider.dart';
import '../../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../../core/vendor/viewobject/paid_ad_item.dart';
import '../../../../../../custom_ui/user/paid_item_list/component/vertical/widgets/paid_ad_item_vertical_list_item.dart';

class PaidAdItemList extends StatelessWidget {
  const PaidAdItemList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final PaidAdItemProvider provider =
        Provider.of<PaidAdItemProvider>(context);
    final PsValueHolder valueHolder =Provider.of<PsValueHolder>(context, listen: false);
    final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count =
        isLoading ? valueHolder.loadingShimmerItemCount! : provider.dataLength;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CustomPaidAdItemVerticalListItem(
              isLoading: isLoading,
              animationController: animationController,
              animation: curveAnimation(animationController,
                  count: count, index: index),
              paidAdItem:
                  isLoading ? PaidAdItem() : provider.getListIndexOf(index),
              tagKey: provider.hashCode.toString());
        },
        childCount: count,
      ),
    );
  }
}
