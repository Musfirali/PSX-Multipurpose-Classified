import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/ui/vendor_ui/common/price_dollar.dart';
import 'package:psxmpc/ui/vendor_ui/item/list_item/product_price_widget.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/paid_ad_item.dart';
import '../../../../../common/bluemark_icon.dart';
import '../../../../../common/ps_ui_widget.dart';

class PaidAdItemHorizontalListItem extends StatelessWidget {
  const PaidAdItemHorizontalListItem({
    Key? key,
    required this.paidAdItem,
    required this.tagKey,
  }) : super(key: key);

  final PaidAdItem paidAdItem;
  final String tagKey;

  void onDetailClick(BuildContext context) {
    final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
        productId: paidAdItem.item!.id,
        // catID: paidAdItem.item!.catId,
        heroTagImage: tagKey + paidAdItem.item!.id! + PsConst.HERO_TAG__IMAGE,
        heroTagTitle: tagKey + paidAdItem.item!.id! + PsConst.HERO_TAG__TITLE);
    Navigator.pushNamed(context, RoutePaths.productDetail, arguments: holder);
  }

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);

    // final bool showDiscount = paidAdItem.item!.isDiscountedItem;

    String statusText = '';
    Color? statusColor;

    if (paidAdItem.isAdWaitingForApproval) {
      statusText = 'paid__ads_waiting'.tr;
      statusColor = PsColors.warning500;
    } else if (paidAdItem.isPaidAdInFinish) {
      statusText = 'paid__ads_in_completed'.tr;
      statusColor = PsColors.success500;
    } else if (paidAdItem.isPaidAdInProgress) {
      statusText = 'paid__ads_in_progress'.tr;
      statusColor = PsColors.info500;
    } else if (paidAdItem.isPaidAdInReject) {
      statusText = 'paid__ads_in_rejected'.tr;
      statusColor = PsColors.error500;
    } else if (paidAdItem.isPaidAdNotYetStart) {
      statusText = 'paid__ads_is_not_yet_start'.tr;
      statusColor = PsColors.achromatic300;
    }

    Widget _statusWidget;
    if (statusColor != null) {
      _statusWidget = Positioned(
        top: PsDimens.space6,
        child: Container(
          margin: const EdgeInsets.only(
              left: PsDimens.space6, right: PsDimens.space6),
          height: 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PsDimens.space4),
              color: statusColor),
          child: Padding(
              padding: const EdgeInsets.all(PsDimens.space4),
              child: Text(statusText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: PsColors.achromatic50))),
        ),
      );
    } else {
      _statusWidget = const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.only(
        right: PsDimens.space4,
      ),
      width: PsDimens.space184,
      child: InkWell(
        onTap: () {
          onDetailClick(context);
        },
        child: Card(
          elevation: 0.0,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Utils.isLightMode(context)
                  ? PsColors.text50
                  : PsColors.achromatic700,
              borderRadius:
                  const BorderRadius.all(Radius.circular(PsDimens.space4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity, //PsDimens.space180,
                      height: PsDimens.space140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(PsDimens.space4),
                        child: PsNetworkImage(
                          photoKey:
                              '$tagKey${paidAdItem.id}${PsConst.HERO_TAG__IMAGE}',
                          defaultPhoto: paidAdItem.item!.defaultPhoto,
                          boxfit: BoxFit.cover,
                          imageAspectRation: PsConst.Aspect_Ratio_2x,
                          onTap: () {
                            onDetailClick(context);
                          },
                        ),
                      ),
                    ),
                    _statusWidget,
                  ],
                ),
                const SizedBox(
                  height: PsDimens.space4,
                ),
              
                Row(
                  children: <Widget>[
                     if (valueHolder.selectPriceType != PsConst.NO_PRICE)
                    Padding(
                        padding: const EdgeInsets.only(left: PsDimens.space8),
                        child: Text('profile__amount'.tr,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w400,))),
                    if (valueHolder.selectPriceType == PsConst.NORMAL_PRICE)
                    Padding(
                      padding: const EdgeInsets.only(right: PsDimens.space8),
                      child: Text(
                          ' : ${paidAdItem.item!.itemCurrency!.currencySymbol} ${paidAdItem.amount}',
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,)),
                    ),
                    if (valueHolder.selectPriceType == PsConst.NO_PRICE)
                    Container(),
                    if (valueHolder.selectPriceType == PsConst.PRICE_RANGE)
                    Row(
                      children: <Widget>[
                        Text(' : ',style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,)),
                        PriceDollar(paidAdItem.amount!)
                      ],
                    ),
                    
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: PsDimens.space8),
                      child: Text('profile__start_date'.tr,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                    ),
                    Flexible(
                      child: Container(
                          margin: const EdgeInsets.only(right: PsDimens.space8),
                          child: Text(
                              ' : ${paidAdItem.startTimeStamp == '' ? '' : Utils.changeTimeStampToStandardDateTimeFormat(paidAdItem.startTimeStamp)}',
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 14))),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: PsDimens.space8),
                      child: Text('profile__end_date'.tr,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w400,  fontSize: 14)),
                    ),
                    Flexible(
                      child: Padding(
                          padding:
                              const EdgeInsets.only(right: PsDimens.space8),
                          child: Text(
                              ' : ${paidAdItem.endTimeStamp == '' ? '' : Utils.changeTimeStampToStandardDateTimeFormat(paidAdItem.endTimeStamp)}',
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                     fontWeight: FontWeight.w400, 
                                      fontSize: 14))),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: PsDimens.space8, left: PsDimens.space8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        paidAdItem.item!.title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       ProductPriceWidget(
                              product: paidAdItem.item!,
                              tagKey: tagKey,
                            ),
                      // Row(
                      //   children: <Widget>[
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: <Widget>[
                      //         PsHero(
                      //           tag:
                      //               '$tagKey${paidAdItem.item!.id}$PsConst.HERO_TAG__UNIT_PRICE',
                      //           flightShuttleBuilder:
                      //               Utils.flightShuttleBuilder,
                      //           child: Material(
                      //               type: MaterialType.transparency,
                      //               child: Text(
                      //                 !showDiscount
                      //                     ? paidAdItem.item!.originalPrice !=
                      //                                 '0' &&
                      //                             paidAdItem.item!
                      //                                     .originalPrice !=
                      //                                 ''
                      //                         ? '${paidAdItem.item!.itemCurrency!.currencySymbol} ${Utils.getPriceFormat(paidAdItem.item!.originalPrice!, valueHolder.priceFormat!)}'
                      //                         : 'item_price_free'.tr
                      //                     : '${paidAdItem.item!.itemCurrency!.currencySymbol} ${Utils.getPriceFormat(paidAdItem.item!.currentPrice!, valueHolder.priceFormat!)}',
                      //                 textAlign: TextAlign.start,
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .bodyMedium!
                      //                     .copyWith(
                      //                         fontSize: 14, color: Theme.of(context).primaryColor),
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
                      //                     '${paidAdItem.item!.itemCurrency!.currencySymbol} ${Utils.getPriceFormat(paidAdItem.item!.originalPrice!, valueHolder.priceFormat!)}  ',
                      //                     textAlign: TextAlign.start,
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .bodyMedium!
                      //                         .copyWith(
                      //                             color: Utils.isLightMode(context) ? PsColors.text600 : PsColors.text300,
                      //                             decoration: TextDecoration
                      //                                 .lineThrough,
                      //                             fontSize: 12),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ))
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: PsDimens.space8,
                      right: PsDimens.space8,
                      top: PsDimens.space4,
                      bottom: PsDimens.space4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
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
                                                ? (paidAdItem
                                                                .item!
                                                                .itemLocationTownship!
                                                                .townshipName !=
                                                            '' &&
                                                        paidAdItem
                                                                .item!
                                                                .itemLocationTownship!
                                                                .townshipName !=
                                                            null)
                                                    ? // check township is empty
                                                    '${paidAdItem.item!.itemLocationTownship!.townshipName}'
                                                    : '${paidAdItem.item!.itemLocation!.name}'
                                                : '${paidAdItem.item!.itemLocation!.name}',
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
                          ),
                        ],
                      ),
                      if (valueHolder.isShowOwnerInfo!)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: PsDimens.space4,
                            top: PsDimens.space4,
                            right: PsDimens.space12,
                            // bottom: PsDimens.space4,
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
                                          paidAdItem.item!.user?.userCoverPhoto,
                                      // width: PsDimens.space40,
                                      // height: PsDimens.space40,
                                      boxfit: BoxFit.cover,
                                      onTap: () {
                                        onDetailClick(context);
                                      },
                                    ),
                                  ),
                                ),
                                if (paidAdItem
                                    .item!.user!.isVefifiedBlueMarkUser)
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
                                                paidAdItem.item!.user
                                                            ?.name ==
                                                        ''
                                                    ? 'default__user_name'.tr
                                                    : '${paidAdItem.item!.user?.name}',
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge),
                                          ),
                                        ],
                                      ),
                                      Text('${paidAdItem.item!.addedDateStr}',
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
                        )
                      else
                        const SizedBox(),
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
}
