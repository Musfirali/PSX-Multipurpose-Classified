import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/constant/ps_constants.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/ui/vendor_ui/common/price_dollar.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({required this.chatFlag});
  final String chatFlag;
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final Product product = itemDetailProvider.product;

    const Widget _spacingWidget = SizedBox(
      height: PsDimens.space4,
    );

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(product.title ?? '',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
          _spacingWidget,
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Expanded(
              child: Text(product.category!.catName ?? '',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(width: PsDimens.space8),
            Padding(
              padding: const EdgeInsets.only(
                left: PsDimens.space6,
                right: PsDimens.space6,
              ),
              child: Icon(
                Icons.chevron_right,
                color: Utils.isLightMode(context)
                    ? PsColors.text800
                    : PsColors.achromatic50,
                size: PsDimens.space20,
              ),
            ),
          ]),
          _spacingWidget,
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            if(valueHolder.selectPriceType == PsConst.NORMAL_PRICE)
            Expanded(
              child: Text(
                product.isPriceGreaterThanZero
                    ? '${product.itemCurrency!.currencySymbol} ${Utils.getPriceFormat(product.originalPrice!, valueHolder.priceFormat!)}' //To Moify Later
                    : 'item_price_free'.tr,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            if(valueHolder.selectPriceType == PsConst.NO_PRICE)
            Container(),
            if(valueHolder.selectPriceType == PsConst.PRICE_RANGE)
            PriceDollar(product.originalPrice!),
            const SizedBox(width: PsDimens.space8),
            if (product.isSoldOutItem)
              Container(
                width: PsDimens.space44,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PsDimens.space8),
                    color: Theme.of(context).primaryColor),
                padding: const EdgeInsets.all(PsDimens.space2),
                child: Text(
                  'chat_view__sold'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800),
                ),
              )
          ])
        ],
      ),
    );
  }
}
