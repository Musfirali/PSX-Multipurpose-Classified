import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/favourite_item_provider.dart';
import '../../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../custom_ui/item/list_item/product_vertical_list_item.dart';
import '../../../../../custom_ui/item/list_item/product_vertical_list_item_for_filter.dart';

class FavoriteProductList extends StatelessWidget {
  const FavoriteProductList(
      {required this.animationController, required this.isGrid});

  final AnimationController animationController;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final FavouriteItemProvider provider =
        Provider.of<FavouriteItemProvider>(context);
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count =
        isLoading ? valueHolder.loadingShimmerItemCount! : provider.dataLength;
    if (isGrid)
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220.0,
            childAspectRatio: valueHolder.isShowOwnerInfo! ? 0.6 : 0.72),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return CustomProductVeticalListItem(
              isLoading: isLoading,
              coreTagKey: provider.hashCode.toString(),
              product: isLoading ? Product() : provider.getListIndexOf(index),
              onTap: () async {
                await provider.resetFavouriteItemList(
                    langProvider.currentLocale.languageCode);
              },
              animation: curveAnimation(animationController,
                  index: index, count: count),
              animationController: animationController,
            );
          },
          childCount: count,
        ),
      );
    else
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return CustomProductVeticalListItemForFilter(
              isLoading: isLoading,
              coreTagKey: provider.hashCode.toString(),
              product: isLoading ? Product() : provider.getListIndexOf(index),
              onTap: () async {
                await provider.resetFavouriteItemList(
                    langProvider.currentLocale.languageCode);
              },
              animation: curveAnimation(animationController,
                  index: index, count: count),
              animationController: animationController,
            );
          },
          childCount: count,
        ),
      );
  }
}
