import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/all_search/all_search_result_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/product_list_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../custom_ui/item/list_item/product_vertical_list_item.dart';
import '../../../../common/ps_list_header_widget.dart';

class ItemResultListWidget extends StatelessWidget {
  const ItemResultListWidget({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final AllSearchResultProvider provider =
        Provider.of<AllSearchResultProvider>(context);
    if ((provider.hasProductList ||
            provider.currentStatus == PsStatus.BLOCK_LOADING) &&
        provider.showProductList) {
      final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
      final int count = isLoading
          ? valueHolder.loadingShimmerItemCount!
          : provider.itemListLength;
      return Column(
        children: <Widget>[
          PsListHeaderWidget(
              headerName: 'all_search__item'.tr,
              viewAllClicked: () {
                final ProductParameterHolder parameterHolder =
                    ProductParameterHolder().getRecentParameterHolder();
                parameterHolder.searchTerm =
                    provider.allSearchParameterHolder.keyword;
                Navigator.pushNamed(context, RoutePaths.filterProductList,
                    arguments: ProductListIntentHolder(
                        appBarTitle: 'Item List'.tr,
                        productParameterHolder: parameterHolder));
              }),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: PsDimens.space10),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 280.0,
                    childAspectRatio:
                        valueHolder.isShowOwnerInfo! ? 0.6 : 0.72),
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  return CustomProductVeticalListItem(
                    coreTagKey: provider.hashCode.toString(),
                    product:
                        isLoading ? Product() : provider.getItemAtIndex(index),
                    isLoading: isLoading,
                    animationController: animationController,
                    animation: curveAnimation(animationController,
                        count: count, index: index),
                  );
                }),
          )
        ],
      );
    } else
      return const SizedBox();
  }
}
