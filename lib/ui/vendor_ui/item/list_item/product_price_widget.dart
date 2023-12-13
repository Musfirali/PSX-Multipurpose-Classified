import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/ui/vendor_ui/common/price_dollar.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../common/ps_hero.dart';


class ProductPriceWidget extends StatelessWidget {
  const ProductPriceWidget({
    Key? key,
    required this.product,
    required this.tagKey,
  }) : super(key: key);

  final Product product;
  final String tagKey;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final bool showDiscount =
        valueHolder.isShowDiscount! && product.isDiscountedItem;
    return valueHolder.selectPriceType == PsConst.NORMAL_PRICE ? Row(
              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    PsHero(
                                      tag:
                                          '$tagKey${product.id}$PsConst.HERO_TAG__UNIT_PRICE',
                                      flightShuttleBuilder:
                                          Utils.flightShuttleBuilder,
                                      child: Material(
                                          type: MaterialType.transparency,
                                          child: Text(
                                            !showDiscount
                                                ? product.originalPrice !=
                                                            '0' &&
                                                        product.originalPrice !=
                                                            ''
                                                    ? '${product.itemCurrency!.currencySymbol}${' '}${Utils.getPriceFormat(product.originalPrice!, valueHolder.priceFormat!)}'
                                                    : 'item_price_free'.tr
                                                : '${product.itemCurrency!.currencySymbol}${' '}${Utils.getPriceFormat(product.currentPrice!, valueHolder.priceFormat!)}',
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontSize: 15, color: Theme.of(context).primaryColor),
                                          )),
                                    ),
                                    Visibility(
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        visible: showDiscount,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: PsDimens.space4),
                                              child: Text(
                                                '${product.itemCurrency!.currencySymbol} ${Utils.getPriceFormat(product.originalPrice!, valueHolder.priceFormat!)}',
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Utils.isLightMode(context) ? PsColors.text600 : PsColors.text300,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ],
                            )
                            : valueHolder.selectPriceType == PsConst.NO_PRICE  ?  Container()
                            : valueHolder.selectPriceType == PsConst.PRICE_RANGE ? 
                             PriceDollar(product.originalPrice!)
                             : Container();
  }

}
