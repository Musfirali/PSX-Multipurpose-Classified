import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/product_list_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../common/ps_ui_widget.dart';
import '../../../../common/shimmer_item.dart';

class CategoryHorizontalListItem extends StatelessWidget {
  const CategoryHorizontalListItem({
    Key? key,
    required this.category,
    this.isLoading = false,
  }) : super(key: key);

  final Category category;
  final bool isLoading;

  void goToSubCategoryList(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.subCategoryGrid,
        arguments: category);
  }

  void goToProductListByCategory(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    final ProductParameterHolder productParameterHolder =
        ProductParameterHolder().getLatestParameterHolder();
    productParameterHolder.catId = category.catId;
    Navigator.pushNamed(context, RoutePaths.filterProductList,
        arguments: ProductListIntentHolder(
          appBarTitle: category.catName,
          productParameterHolder: productParameterHolder,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Container(
        margin: const EdgeInsets.symmetric(
            horizontal: PsDimens.space6, vertical: PsDimens.space8),
        child: Container(
          // decoration: BoxDecoration(
          //   color: PsColors.cardBackgroundColor,
          //   borderRadius:
          //       const BorderRadius.all(Radius.circular(PsDimens.space16)),
          // ),
          width: PsDimens.space80,
          height: PsDimens.space80,
          child: isLoading
              ? const ShimmerItem()
              : InkWell(
                  onTap: () {
                    if (psValueHolder.isShowSubcategory!) {
                      goToSubCategoryList(context);
                    } else {
                      goToProductListByCategory(context);
                    }
                  },
                  child: Ink(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //cat image
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(PsDimens.space24),
                            child: Container(
                              width: PsDimens.space44,
                              height: PsDimens.space44,
                              color: Utils.isLightMode(context)
                                  ? PsColors.text100
                                  : PsColors.achromatic200,
                              padding: const EdgeInsets.all(PsDimens.space10),
                              child: PsNetworkIcon(
                                imageAspectRation: PsConst.Aspect_Ratio_1x,
                                photoKey: '',
                                defaultIcon: category.defaultIcon,
                                boxfit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: PsDimens.space8,
                          ),
                          //cat name
                          Flexible(
                            child: Text(
                              category.catName!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Utils.isLightMode(context)
                                          ? PsColors.text600 : PsColors.text50,
                                      fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }
}
