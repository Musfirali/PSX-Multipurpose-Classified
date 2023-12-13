import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart' show PsDimens;
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/product_list_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';

class CategoryResultListItem extends StatelessWidget {
  const CategoryResultListItem(
      {Key? key,
      required this.category,
      required this.animationController,
      required this.animation,
      this.isLoading = false})
      : super(key: key);

  final Category category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    animationController?.forward();
    return AnimatedBuilder(
        animation: animationController!,
        child: InkWell(
          highlightColor: PsColors.primary50,
          onTap: () {
            if (psValueHolder.isShowSubcategory!) {
              goToSubCategoryList(context, category);
            } else {
              goToProductListByCategory(context, category);
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: PsDimens.space10, horizontal: PsDimens.space16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  category.catName ?? '',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Utils.isLightMode(context) ? PsColors.text900: PsColors.text50,
                      fontSize: 16),
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 100 * (1.0 - animation!.value), 0.0),
                child: child),
          );
        });
  }

  void goToSubCategoryList(BuildContext context, Category category) {
    Navigator.pushNamed(context, RoutePaths.subCategoryGrid,
        arguments: category);
  }

  void goToProductListByCategory(BuildContext context, Category category) {
    final ProductParameterHolder productParameterHolder =
        ProductParameterHolder().getLatestParameterHolder();
    productParameterHolder.catId = category.catId;
    Navigator.pushNamed(context, RoutePaths.filterProductList,
        arguments: ProductListIntentHolder(
          appBarTitle: category.catName,
          productParameterHolder: productParameterHolder,
        ));
  }
}
