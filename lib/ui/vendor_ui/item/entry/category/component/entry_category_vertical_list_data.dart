import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../custom_ui/item/entry/category/component/entry_category_vertical_list_item.dart';

class EntryCategoryVerticalListData extends StatelessWidget {
  const EntryCategoryVerticalListData({
    required this.animationController,
    this.onItemUploaded,
    this.isFromChat});

  final AnimationController animationController;
  final Function? onItemUploaded;
  final bool? isFromChat;

  @override
  Widget build(BuildContext context) {
    final CategoryProvider provider = Provider.of<CategoryProvider>(context);
    final PsValueHolder valueHolder =Provider.of<PsValueHolder>(context, listen: false);
    final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count =
        isLoading ? valueHolder.loadingShimmerItemCount! : provider.dataLength;
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 170.0, 
          childAspectRatio: 0.95),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CustomEntryCategoryVerticalListItem(
            animationController: animationController,
            animation:
                curveAnimation(animationController, count: count, index: index),
            category: isLoading ? Category() : provider.getListIndexOf(index),
            isLoading: isLoading,
            currentIndex: index,
            onItemUploaded: onItemUploaded,
            isFromChat: isFromChat
          );
        },
        childCount: count,
      ),
    );
  }
}
