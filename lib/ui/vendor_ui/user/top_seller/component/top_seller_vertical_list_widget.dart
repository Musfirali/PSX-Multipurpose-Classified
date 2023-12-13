import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/user/top_seller_provider.dart';
import 'package:psxmpc/core/vendor/utils/ps_animation.dart';
import 'package:psxmpc/core/vendor/viewobject/user.dart';
import 'package:psxmpc/ui/custom_ui/category/component/menu_vertical/widgets/vertical_list/category_sorting_empty_data_box.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../custom_ui/user/top_seller/component/widgets/topseller_list_item.dart';

class TopSellerVerticalListWidget extends StatelessWidget {
  const TopSellerVerticalListWidget(
      {required this.animationController, required this.controller});

  final AnimationController animationController;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<TopSellerProvider>(builder:
        (BuildContext context, TopSellerProvider provider, Widget? child) {
      final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
      final int count = isLoading ? 5 : provider.dataLength;
      final double ratio = (MediaQuery.of(context).size.height >
              MediaQuery.of(context).size.width)
          ? MediaQuery.of(context).size.height /
              MediaQuery.of(context).size.width /
              1.8
          : MediaQuery.of(context).size.width /
              MediaQuery.of(context).size.height /
              0.85;

      return (provider.hasData ||
              provider.currentStatus == PsStatus.BLOCK_LOADING)
          ?
          // Flexible(
          //   child:
          SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.8,
                  childAspectRatio: ratio),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return CustomTopSellerListItem(
                    animationController: animationController,
                    animation: curveAnimation(animationController,
                        count: count, index: index),
                    user: isLoading ? User() : provider.getListIndexOf(index),
                    isLoading: isLoading,
                  );
                },
                childCount: count,
              ),
            )
          : CustomCategorySortingEmptyBox();
    });
  }
}
