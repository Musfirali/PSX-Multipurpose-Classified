import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/constant/ps_constants.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/product_provider.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/message.dart';
import 'package:psxmpc/core/vendor/viewobject/product.dart';

class ChatPriceWidget extends StatelessWidget {
  const ChatPriceWidget({
    Key? key,
    required this.messageObj,
  }) : super(key: key);

  final Message messageObj;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final Product? itemDetail = itemDetailProvider.product;
    return  valueHolder.selectPriceType == PsConst.NORMAL_PRICE
            ? Text(
                itemDetail!.originalPrice != '0'
                    ? Utils.getChatPriceFormat(
                        messageObj.message!, valueHolder.priceFormat!)
                    : 'item_price_free'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: PsColors.achromatic50),
              )
            : valueHolder.selectPriceType == PsConst.NO_PRICE
                ? Container()
                : valueHolder.selectPriceType == PsConst.PRICE_RANGE
                    ? Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            child: PriceDollar(Utils.getChatPriceFormat(
                                messageObj.message!,
                                valueHolder.priceFormat!))),
                      ])
                    : Container();
  }
}

class PriceDollar extends StatelessWidget {
  const PriceDollar(this.value);
  final String value;
  // ignore: avoid_field_initializers_in_const_classes
  final int maxDollar = 5;

  @override
  Widget build(BuildContext context) {
    final String extractedValue =
        value.replaceAll('\$', '').replaceAll('.00', '');
    final int parsedValue = int.tryParse(extractedValue) ?? 0;

    return Row(
      // ignore: always_specify_types
      children: List.generate(maxDollar, (int index) {
        return Text(
          '\$',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16.0,
            color: index < parsedValue
                ? Theme.of(context).primaryColor
                : PsColors.text400,
          ),
        );
      }),
    );
  }
}
