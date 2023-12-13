import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart' show PsDimens;
import '../../../../../../core/vendor/provider/all_search/all_search_result_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../custom_ui/all_search/component/search_result/category/category_result_list_text_item.dart';
import '../../../../../custom_ui/category/component/menu_vertical/widgets/vertical_list/category_vertical_list_item.dart';
import '../../../../common/ps_list_header_widget.dart';

class CategoryResultListWidget extends StatelessWidget {
  const CategoryResultListWidget({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final AllSearchResultProvider provider =
        Provider.of<AllSearchResultProvider>(context);
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    if ((provider.hasCategoryList ||
            provider.currentStatus == PsStatus.BLOCK_LOADING) &&
        provider.showCategoryList) {
      final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
      final int count = isLoading
          ? valueHolder.loadingShimmerItemCount!
          : provider.categoryListLength;
      return Column(children: <Widget>[
        PsListHeaderWidget(
            headerName: 'all_search__category'.tr,
            viewAllClicked: () {
              Navigator.pushNamed(context, RoutePaths.categoryList,
                  arguments: provider.allSearchParameterHolder.keyword ?? '');
            }),
        if (provider.showAll)
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: count,
              itemBuilder: (BuildContext context, int index) {
                final Category category = provider.getCategoryAtIndex(index);
                return CustomCategoryResultListItem(
                  animationController: animationController,
                  animation: curveAnimation(animationController,
                      count: count, index: index),
                  category: isLoading ? Category() : category,
                  isLoading: isLoading,
                );
              })
        else if (provider.showOnlyCategoryList)
          Container(
            margin: const EdgeInsets.only(left: PsDimens.space16),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 99, childAspectRatio: 0.95),
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  final Category category = provider.getCategoryAtIndex(index);
                  return CustomCategoryVerticalListItem(
                    animationController: animationController,
                    animation: curveAnimation(animationController,
                        count: count, index: index),
                    category: isLoading ? Category() : category,
                    isLoading: isLoading,
                  );
                }),
          ),
      ]);
    } else
      return const SizedBox();
  }
}
