import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/product_list_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/sub_category.dart';
import '../../../../common/ps_ui_widget.dart';
import '../../../../common/shimmer_item.dart';

class SubCategoryGridItem extends StatefulWidget {
  const SubCategoryGridItem(
      {Key? key,
      required this.subCategory,
      required this.animationController,
      required this.animation,
      this.isLoading = false})
      : super(key: key);

  final SubCategory subCategory;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;

  @override
  State<SubCategoryGridItem> createState() => _SubCategoryGridItemState();
}

class _SubCategoryGridItemState extends State<SubCategoryGridItem> {
  late SubCategoryProvider provider;
  late PsValueHolder valueHolder;

  void subscribeCurrentSubCategory() {
    setState(() {
      if (provider.tempList.contains(widget.subCategory.id)) {
        provider.tempList.remove(widget.subCategory.id);
        provider.unsubscribeListWithMB.add(widget.subCategory.id! + '_MB');
      } else {
        provider.tempList.add(widget.subCategory.id);
        provider.unsubscribeListWithMB.remove(widget.subCategory.id! + '_MB');
      }

      if (provider.subscribeList.contains(widget.subCategory.id))
        provider.subscribeList.remove(widget.subCategory.id);
      else
        provider.subscribeList.add(widget.subCategory.id);
      provider.needToAddToTempList = false;
    });
  }

  void goToProductList() {
    provider.subCategoryByCatIdParamenterHolder.mile = valueHolder.mile;
    provider.subCategoryByCatIdParamenterHolder.catId =
        widget.subCategory.catId;
    provider.subCategoryByCatIdParamenterHolder.subCatId =
        widget.subCategory.id;
    Navigator.pushNamed(context, RoutePaths.filterProductList,
        arguments: ProductListIntentHolder(
            appBarTitle: widget.subCategory.name,
            productParameterHolder:
                provider.subCategoryByCatIdParamenterHolder));
  }

  @override
  Widget build(BuildContext context) {
    widget.animationController!.forward();
    provider = Provider.of<SubCategoryProvider>(context);
    valueHolder = Provider.of<PsValueHolder>(context);

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: PsDimens.space4, vertical: PsDimens.space8),
      child: widget.isLoading
          ? const ShimmerItem()
          : AnimatedBuilder(
              animation: widget.animationController!,
              child: InkWell(
                onTap: () {
                  if (provider.subscriptionMode) {
                    subscribeCurrentSubCategory();
                  } else {
                    goToProductList();
                  }
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      // decoration: BoxDecoration(
                      //    color: PsColors.cardBackgroundColor,
                      //   borderRadius: const BorderRadius.all(
                      //       Radius.circular(PsDimens.space16)),
                      // ),
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
                                      : PsColors.text300,
                                  padding:
                                      const EdgeInsets.all(PsDimens.space10),
                                  child: PsNetworkIcon(
                                    imageAspectRation: PsConst.Aspect_Ratio_1x,
                                    photoKey: '',
                                    defaultIcon: widget.subCategory.defaultIcon,
                                    boxfit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: PsDimens.space8,
                              ),
                              Flexible(
                                child: Text(
                                  widget.subCategory.name ?? '',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Utils.isLightMode(context)
                                              ? PsColors.text600
                                              : Utils.isLightMode(context) ? PsColors.text300: PsColors.text50,
                                          fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: provider.subscriptionMode,
                      child: Positioned(
                        top: 1,
                        right: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            child: Icon(
                              Icons.circle,
                              color: provider.tempList
                                      .contains(widget.subCategory.id)
                                  ? Theme.of(context).primaryColor
                                  : Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return FadeTransition(
                  opacity: widget.animation!,
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 100 * (1.0 - widget.animation!.value), 0.0),
                      child: child),
                );
              }),
    );
  }
}
