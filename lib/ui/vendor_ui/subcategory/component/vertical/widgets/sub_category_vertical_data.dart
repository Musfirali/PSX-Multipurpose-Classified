import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/sub_category.dart';
import '../../../../../custom_ui/subcategory/component/vertical/widgets/sub_category_vertical_item.dart';

class SubCategoryVerticalData extends StatelessWidget {
  const SubCategoryVerticalData({required this.animationController});
  final AnimationController animationController;

  void addAlreadySubscribedDataToTemp(
      SubCategory subCategory, SubCategoryProvider provider) {
    if (subCategory.isSubscribe != null &&
        subCategory.isSubscribe == PsConst.ONE &&
        !provider.tempList.contains(subCategory.id) &&
        provider.needToAddToTempList) {
      provider.tempList.add(subCategory.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SubCategoryProvider provider =
        Provider.of<SubCategoryProvider>(context);
    final PsValueHolder valueHolder =Provider.of<PsValueHolder>(context, listen: false);
    final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count =
        isLoading ? valueHolder.loadingShimmerItemCount! : provider.dataLength;
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100.0, childAspectRatio: 0.8),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          addAlreadySubscribedDataToTemp(
              isLoading ? SubCategory() : provider.getListIndexOf(index),
              provider);
          return CustomSubCategoryGridItem(
              isLoading: isLoading,
              subCategory:
                  isLoading ? SubCategory() : provider.getListIndexOf(index),
              animationController: animationController,
              animation: curveAnimation(animationController,
                  count: count, index: index));
        },
        childCount: count,
      ),
    );
  }
}
