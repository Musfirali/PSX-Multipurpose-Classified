import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../custom_ui/item/list_item/product_horizontal_list_item.dart';

class ProductHorizontalListWidget extends StatelessWidget {
  const ProductHorizontalListWidget(
      {required this.tagKey,
      required this.productList,
      required this.isLoading,
      this.height});
  final List<Product>? productList;
  final String tagKey;
  final bool isLoading;
  final double? height;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return Container(
        height: height ??
            (valueHolder.isShowOwnerInfo!
                ? PsDimens.space280
                : PsDimens.space220),
        margin: const EdgeInsets.only(left: PsDimens.space14),
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: isLoading
                ? valueHolder.loadingShimmerItemCount
                : productList!.length,
            itemBuilder: (BuildContext context, int index) {
              if (!isLoading &&
                  productList![index].adType == PsConst.GOOGLE_AD_TYPE) {
                return const SizedBox();
              }
              return CustomProductHorizontalListItem(
                tagKey: tagKey,
                product: isLoading ? Product() : productList![index],
                isLoading: isLoading,
              );
            }));
  }
}
