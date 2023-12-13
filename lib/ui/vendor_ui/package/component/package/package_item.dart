import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/package.dart';

class PackageItem extends StatelessWidget {
  const PackageItem({
    Key? key,
    required this.package,
    required this.onTap,
    required this.priceWithCurrency,
  }) : super(key: key);

  final Package package;
  final Function? onTap;
  final String priceWithCurrency;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space16, bottom: PsDimens.space16),
      padding: const EdgeInsets.only(
          top: PsDimens.space10,
          right: PsDimens.space16,
          bottom: PsDimens.space10),
      decoration: BoxDecoration(
        color: Utils.isLightMode(context)
            ? PsColors.text50
            : PsColors.text800,
        borderRadius: BorderRadius.circular(PsDimens.space4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(package.paymentInfo!.value!,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    priceWithCurrency,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.check_circle_outlined,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        'Upload ${package.paymentAttributes!.count} posts.',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            // color: PsColors
                            //     .textColor2,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(
            color: Theme.of(context).primaryColor,
            minWidth: 95,
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
        ],
      ),
    );
  }
}
