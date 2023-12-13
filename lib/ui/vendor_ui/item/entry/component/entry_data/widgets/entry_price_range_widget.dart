import 'package:flutter/material.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/core_field.dart';

class EntryPriceRangeWidget extends StatelessWidget {
  const EntryPriceRangeWidget(
      {Key? key,
      required this.currencySymbolController,
      required this.userInputPriceController,
      required this.currencyCoreField,
      required this.priceCoreField})
      : super(key: key);

  final TextEditingController? currencySymbolController;
  final TextEditingController? userInputPriceController;
  final CoreField currencyCoreField;
  final CoreField priceCoreField;

  @override
  Widget build(BuildContext context) {
    int dollarCount = 0;
    if (int.tryParse(userInputPriceController!.text) != null) {
      dollarCount = int.parse(userInputPriceController!.text);
    }
    const String str = '\$\$\$\$\$';

    if (dollarCount > 5) {
      dollarCount = 5;
    } else if (dollarCount < 1) {
      dollarCount = 0;
    }

    String firstPart = str.substring(0, dollarCount);
    String secondPart = str.substring(dollarCount, str.length);
    final Widget _productTextWithStarWidget = Row(
      children: <Widget>[
        Text('item_entry__price'.tr,
            style: Theme.of(context).textTheme.titleMedium),
        if (priceCoreField.isMandatory)
          Text('*',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).primaryColor))
      ],
    );

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
              left: PsDimens.space16,
              top: PsDimens.space12,
              right: PsDimens.space16),
          child: Row(
            children: <Widget>[_productTextWithStarWidget],
          ),
        ),
        InkWell(
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());

            final dynamic priceResult = await Navigator.pushNamed(
                context, RoutePaths.choosePrice,
                arguments: dollarCount);

            if (priceResult != null && priceResult is int) {
              userInputPriceController!.text = priceResult.toString();
              dollarCount = priceResult;
              firstPart = str.substring(0, priceResult);
              secondPart = str.substring(priceResult, str.length);
            }
          },
          child: Container(
            // color: PsColors.primary50,
            width: double.infinity,
            height: PsDimens.space44,
            margin: const EdgeInsets.only(
                top: PsDimens.space12,
                left: PsDimens.space16,
                right: PsDimens.space16,
                bottom: PsDimens.space12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PsDimens.space4),
              border: Border.all(color: PsColors.text400),
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: PsDimens.space12, right: PsDimens.space12),
                        child: dollarCount == 0
                            ? Text(
                             userInputPriceController!.text == '0' ? '\$\$\$\$\$' :'select_price_range'.tr ,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: PsColors.text400),
                              )
                            : RichText(
                                text: TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Utils.isLightMode(context)
                                              ? PsColors.achromatic600
                                              : PsColors.achromatic100,
                                        ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: firstPart,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Utils.isLightMode(context)
                                                  ? PsColors.primary500
                                                  : PsColors.primary300,
                                            ),
                                      ),
                                      TextSpan(
                                        text: secondPart,
                                      ),
                                    ]),
                              ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: PsDimens.space20),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
