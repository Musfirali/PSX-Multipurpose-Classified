import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class CustomPromoteItem extends StatefulWidget {
  const CustomPromoteItem(
      {required this.onTap, required this.getEnterDateCountController});
  final Function onTap;
  final TextEditingController getEnterDateCountController;
  @override
  State<StatefulWidget> createState() => _CustomPromoteItemState();
}

class _CustomPromoteItemState extends State<CustomPromoteItem> {
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final AppInfoProvider appInfoProvider =
        Provider.of<AppInfoProvider>(context);
    final String currencySymbol = appInfoProvider.appInfo.data!.currencySymbol!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Input Custom Days'.tr,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Utils.isLightMode(context)
                ? PsColors.achromatic100
                : PsColors.achromatic600,
            borderRadius: BorderRadius.circular(PsDimens.space4),
            border: Border.all(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic200
                    : PsColors.achromatic900,)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: PsDimens.space100,
                          height: 40,
                          margin: const EdgeInsets.only(
                              left: PsDimens.space16, top: 10),
                          decoration: BoxDecoration(
                            color: Utils.isLightMode(context)
                                ? PsColors.achromatic200
                                : PsColors.achromatic800,
                            borderRadius:
                                BorderRadius.circular(PsDimens.space4),
                            border: Border.all(
                                color: Utils.isLightMode(context)
                                    ? PsColors.achromatic200
                                    : PsColors.achromatic900),
                          ),
                          child: TextField(
                              onChanged: (String text) {
                                print('dddd');
                                if (double.parse(widget
                                        .getEnterDateCountController.text) >
                                    0.0) {
                                  setState(() {});
                                }
                              },
                              onTap: widget.onTap as void Function(),
                              keyboardType: TextInputType.number,
                              maxLines: null,
                              controller: widget.getEnterDateCountController,
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: PsDimens.space12,
                                    right: PsDimens.space12,
                                    bottom: PsDimens.space10),
                                border: InputBorder.none,
                              )),
                        ),
                        const SizedBox(
                          width: PsDimens.space8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: PsDimens.space4, top: 15),
                          child: Text('item_promote__days'.tr),
                        ),
                      ],
                    ),
                    if (widget.getEnterDateCountController.text != '' &&
                        double.parse(widget.getEnterDateCountController.text) >
                            0.0)
                      Container(
                        padding: const EdgeInsets.only(
                            left: PsDimens.space16, top: 8),
                        child: Text(currencySymbol.tr +
                            '-' +
                            Utils.getPriceFormat(
                                (double.parse(widget
                                            .getEnterDateCountController.text) *
                                        double.parse(
                                            appInfoProvider.pricePerOneDay))
                                    .toString(),
                                psValueHolder.priceFormat!)),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(
                            left: PsDimens.space16, top: 8),
                        child: Text(currencySymbol.tr +
                            ' -' +
                            widget.getEnterDateCountController.text),
                      ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 4, bottom: 8, left: 14),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.check_circle_outlined,
                            size: 18,
                          ),
                          Text(
                              'item_promote__promote_for'.tr +
                                  widget.getEnterDateCountController.text +
                                  'item_promote__promote_for_days'.tr,
                              style:
                                  Theme.of(context).textTheme.bodySmall!.copyWith(
                                        // color: PsColors
                                        //     .textColor1,
                                        fontSize: 18,
                                      )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                child: MaterialButton(
                  color: Theme.of(context).primaryColor,
                  minWidth: 100,
                  height: 40,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(PsDimens.space4)),
                  ),
                  child: Text(
                    'item_promote__purchase_buy'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800),
                  ),
                  onPressed: widget.onTap as void Function()?,
                ),
              ),
            ],
          ),
          // ),
        ),
      ],
    );
  }
}
