import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/core_field.dart';
import '../../../../../../../core/vendor/viewobject/item_currency.dart';
import '../core_and_custom_field_entry_view.dart';

class EntryPriceWidget extends StatelessWidget {
  const EntryPriceWidget(
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
    final ItemEntryProvider provider = Provider.of<ItemEntryProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
              top: PsDimens.space12,
              right: PsDimens.space16,
              left: PsDimens.space16),
          child: Row(
            children: <Widget>[
              Text(
                'item_entry__price'.tr,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (priceCoreField.isMandatory || currencyCoreField.isMandatory)
                Text(' *',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.primary500
                            : PsColors.primary300))
            ],
          ),
        ),
        Container(
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
          child: Row(
            children: <Widget>[
              CoreFieldContainer(
                coreField: currencyCoreField,
                child: InkWell(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());

                    final dynamic itemCurrencySymbolResult =
                        await Navigator.pushNamed(
                            context, RoutePaths.itemCurrencySymbol,
                            arguments: currencySymbolController!.text);

                    if (itemCurrencySymbolResult != null &&
                        itemCurrencySymbolResult is ItemCurrency) {
                      provider.itemCurrencyId = itemCurrencySymbolResult.id;

                      currencySymbolController!.text =
                          itemCurrencySymbolResult.currencySymbol!;
                    }
                  },
                  child: Container(
                    width: PsDimens.space40,
                    height: PsDimens.space44,
                    margin: const EdgeInsets.symmetric(
                        horizontal: PsDimens.space12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            currencySymbolController!.text,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: Utils.isLightMode(context)
                    ? PsColors.text400
                    : PsColors.text300,
                width: PsDimens.space1,
              ),
              Expanded(
                child: CoreFieldContainer(
                  coreField: priceCoreField,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: PsDimens.space44,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLines: null,
                      controller: userInputPriceController,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.normal),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: PsDimens.space12, bottom: PsDimens.space4),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
