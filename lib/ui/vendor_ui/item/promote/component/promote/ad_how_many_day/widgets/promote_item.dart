import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';

class PromoteItem extends StatelessWidget {
  const PromoteItem(
      {required this.onTap,
      //// required this.isCurrentSelected,
      required this.day,
      required this.product,
      required this.amount});
  final Function onTap;
// final bool isCurrentSelected;
  final String day;
  final String amount;
  final Product product;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final AppInfoProvider appInfoProvider =
        Provider.of<AppInfoProvider>(context);
    final String? currencySymbol = appInfoProvider.appInfo.data!.currencySymbol;
    return
        // InkWell(
        //   onTap: onTap as void Function(),
        //   child:
        Container(
      margin: const EdgeInsets.only(
        bottom: PsDimens.space16,
      ),
      padding: const EdgeInsets.only(
          top: PsDimens.space10,
          right: PsDimens.space16,
          bottom: PsDimens.space10),
      decoration: BoxDecoration(
        color:
            Utils.isLightMode(context) ? PsColors.achromatic100 : PsColors.achromatic600,
        borderRadius: BorderRadius.circular(PsDimens.space4),
        border: Border.all(
            color: Utils.isLightMode(context)
                ? PsColors.achromatic200
                : PsColors.achromatic900),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(day + ' ' + 'days',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 2.0),
                  child: Text(
                    currencySymbol!.tr +
                        ' ' +
                        Utils.getPriceFormat(
                            amount, psValueHolder.priceFormat!),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14, top: 3),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.check_circle_outlined,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                          'item_promote__promote_for'.tr +
                              day +
                              ' ' +
                              'item_promote__promote_for_days'.tr,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                // color: PsColors
                                //     .textColor1,
                                fontSize: 16,
                              )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: MaterialButton(
              color: Theme.of(context).primaryColor,
              minWidth: 100,
              height: 40,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(PsDimens.space4)),
              ),
              child: Text(
                'item_promote__purchase_buy'.tr,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800),
              ),
              onPressed: onTap as void Function()?,
            ),
          ),
        ],
        // ),
      ),
    );
  }
}
