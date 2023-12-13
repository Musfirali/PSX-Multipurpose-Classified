import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/ui/custom_ui/item/list_item/product_price_widget.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../common/bluemark_icon.dart';
import '../../common/ps_ui_widget.dart';
import '../../common/shimmer_item.dart';

class ProductVeticalListItem extends StatelessWidget {
  const ProductVeticalListItem(
      {Key? key,
      required this.product,
      this.onTap,
      this.coreTagKey,
      required this.animationController,
      required this.animation,
      this.isLoading = false})
      : super(key: key);

  final Product product;
  final Function? onTap;
  final AnimationController animationController;
  final Animation<double> animation;
  final String? coreTagKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    //print("${PsConfig.ps_app_image_thumbs_url}${subCategory.defaultPhoto.imgPath}");
    animationController.forward();
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    // final bool showDiscount =
    //     valueHolder.isShowDiscount! && product.isDiscountedItem;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
            opacity: animation,
            child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 100 * (1.0 - animation.value), 0.0),
                child: child));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: PsDimens.space4, vertical: PsDimens.space8),
        child: isLoading
            ? const ShimmerItem()
            : GestureDetector(
                onTap: () {
                  onDetailClick(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Utils.isLightMode(context)
                        ? PsColors.text50
                        : PsColors.achromatic700,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(PsDimens.space8)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity, //PsDimens.space180,
                              height: double.infinity,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(PsDimens.space6),
                                child: PsNetworkImage(
                                  photoKey:
                                      '$coreTagKey${product.id}${PsConst.HERO_TAG__IMAGE}',
                                  defaultPhoto: product.defaultPhoto,
                                  boxfit: BoxFit.cover,
                                  imageAspectRation: PsConst.Aspect_Ratio_2x,
                                  onTap: () {
                                    onDetailClick(context);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  if (product.isSoldOutItem)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: PsDimens.space4,
                                          left: PsDimens.space4,
                                          right: PsDimens.space4),
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              PsDimens.space4),
                                          color: Theme.of(context).primaryColor),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: PsDimens.space4,
                                              left: PsDimens.space4,
                                              right: PsDimens.space4),
                                          child: Text('dashboard__sold_out'.tr,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: PsColors.achromatic50))),
                                    ),
                                  if (product.paidStatus ==
                                      PsConst.PAID_AD_PROGRESS)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: PsDimens.space4,
                                          left: PsDimens.space4,
                                          right: PsDimens.space4),
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              PsDimens.space4),
                                          color: PsColors.success400),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: PsDimens.space4,
                                              left: PsDimens.space4,
                                              right: PsDimens.space4),
                                          child: Text(
                                              'dashboard__is_featured'.tr,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: PsColors.achromatic50))),
                                    ),
                                  if (product.isDiscountedItem)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: PsDimens.space6,
                                          left: PsDimens.space6,
                                          right: PsDimens.space4),
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              PsDimens.space4),
                                          color: PsColors.error500),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: PsDimens.space4,
                                              left: PsDimens.space4,
                                              right: PsDimens.space4),
                                          child: Text(
                                              '${product.discountRate}% ${'dashboard__is_discount'.tr}',
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: PsColors.achromatic50))),
                                    ),
                                ],
                              ),
                            ),
                            if (!Utils.isOwnerItem(valueHolder, product))
                              Positioned(
                                  top: PsDimens.space6,
                                  right: PsDimens.space6,
                                  child: GestureDetector(
                                      onTap: () {
                                        onDetailClick(context);
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              top: PsDimens.space4,
                                              left: PsDimens.space4,
                                              right: PsDimens.space4,
                                              bottom: PsDimens.space4),
                                          decoration: BoxDecoration(
                                              color: PsColors.achromatic50,
                                              border: Border.all(
                                                  color: PsColors.achromatic50),
                                              shape: BoxShape.circle),
                                          child: product.isFavourited ==
                                                      PsConst.ZERO ||
                                                  Utils.isLoginUserEmpty(
                                                      valueHolder)
                                              ? Icon(Icons.favorite_border,
                                                  color: PsColors.text500,
                                                  size: 20)
                                              : Icon(Icons.favorite,
                                                  color: Theme.of(context).primaryColor,
                                                  size: 20)))),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: PsDimens.space8,
                                  right: PsDimens.space8,
                                  left: PsDimens.space8),
                              child: Text(
                                product.title!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: PsDimens.space8,
                            right: PsDimens.space8,
                            top: PsDimens.space4,
                            bottom: PsDimens.space4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                             CustomProductPriceWidget(
                              product: product,
                              tagKey: coreTagKey!,
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: <Widget>[
                            //         PsHero(
                            //           tag:
                            //               '$coreTagKey${product.id}$PsConst.HERO_TAG__UNIT_PRICE',
                            //           flightShuttleBuilder:
                            //               Utils.flightShuttleBuilder,
                            //           child: Material(
                            //               type: MaterialType.transparency,
                            //               child: Text(
                            //                 !showDiscount
                            //                     ? product.originalPrice !=
                            //                                 '0' &&
                            //                             product.originalPrice !=
                            //                                 ''
                            //                         ? '${product.itemCurrency!.currencySymbol}${' '}${Utils.getPriceFormat(product.originalPrice!, valueHolder.priceFormat!)}'
                            //                         : 'item_price_free'.tr
                            //                     : '${product.itemCurrency!.currencySymbol}${' '}${Utils.getPriceFormat(product.currentPrice!, valueHolder.priceFormat!)}',
                            //                 textAlign: TextAlign.start,
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodyMedium!
                            //                     .copyWith(
                            //                         fontSize: 15, color: Theme.of(context).primaryColor),
                            //               )),
                            //         ),
                            //         Visibility(
                            //             maintainSize: true,
                            //             maintainAnimation: true,
                            //             maintainState: true,
                            //             visible: showDiscount,
                            //             child: Row(
                            //               children: <Widget>[
                            //                 Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       bottom: PsDimens.space4),
                            //                   child: Text(
                            //                     '${product.itemCurrency!.currencySymbol}${Utils.getPriceFormat(product.originalPrice!, valueHolder.priceFormat!)}  ',
                            //                     textAlign: TextAlign.start,
                            //                     style: Theme.of(context)
                            //                         .textTheme
                            //                         .bodyMedium!
                            //                         .copyWith(
                            //                             color: Utils.isLightMode(context) ? PsColors.text600 : PsColors.text300,
                            //                             decoration:
                            //                                 TextDecoration
                            //                                     .lineThrough,
                            //                             fontSize: 12),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ))
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 12,
                                  color: Utils.isLightMode(context) ? PsColors.text500 : PsColors.text400,
                                ),
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: PsDimens.space4,
                                            right: PsDimens.space4),
                                        child: Text(
                                            valueHolder.isSubLocation ==
                                                    PsConst.ONE
                                                ? (product.itemLocationTownship!
                                                                .townshipName !=
                                                            '' &&
                                                        product.itemLocationTownship!
                                                                .townshipName !=
                                                            null)
                                                    ? // check optional township is empty
                                                    '${product.itemLocationTownship!.townshipName}'
                                                    : '${product.itemLocation!.name}'
                                                : '${product.itemLocation!.name}',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: Utils.isLightMode(context) ? PsColors.text500 : PsColors.text400,)))),
                              ],
                            ),
                            if (valueHolder.isShowOwnerInfo!)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: PsDimens.space4,
                                  right: PsDimens.space12,
                                  top: PsDimens.space8,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Stack(children: <Widget>[
                                      Container(
                                        child: SizedBox(
                                          width: PsDimens.space40,
                                          height: PsDimens.space40,
                                          child: PsNetworkCircleImageForUser(
                                            photoKey: '',
                                            imagePath:
                                                product.user?.userCoverPhoto,
                                            // width: PsDimens.space40,
                                            // height: PsDimens.space40,
                                            boxfit: BoxFit.cover,
                                            onTap: () {
                                              onDetailClick(context);
                                            },
                                          ),
                                        ),
                                      ),
                                      if (product.user!.isVefifiedBlueMarkUser)
                                        const Positioned(
                                          right: -1,
                                          bottom: -1,
                                          child: BluemarkIcon(),
                                        ),
                                    ]),
                                    const SizedBox(width: PsDimens.space8),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: PsDimens.space8,
                                            top: PsDimens.space8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                      product.user?.name ==
                                                              ''
                                                          ? 'default__user_name'
                                                              .tr
                                                          : '${product.user?.name}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge),
                                                ),
                                              ],
                                            ),
                                            Text('${product.addedDateStr}',
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!.copyWith(color: Utils.isLightMode(context) ? PsColors.text500 : PsColors.text400))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            const SizedBox(
                              height: PsDimens.space6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> onDetailClick(BuildContext context) async {
    final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
        productId: product.id,
        heroTagImage: coreTagKey! + product.id! + PsConst.HERO_TAG__IMAGE,
        heroTagTitle: coreTagKey! + product.id! + PsConst.HERO_TAG__TITLE);
    await Navigator.pushNamed(context, RoutePaths.productDetail,
        arguments: holder);
    if (onTap != null) {
      onTap!();
    }
  }
}
