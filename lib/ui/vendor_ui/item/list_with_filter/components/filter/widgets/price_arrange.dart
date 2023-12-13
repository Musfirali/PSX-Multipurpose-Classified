import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class PriceArragementWidget extends StatelessWidget {
  const PriceArragementWidget(
      {Key? key, this.minPriceTextController, this.maxPriceTextController})
      : super(key: key);

  final TextEditingController? minPriceTextController;
  final TextEditingController? maxPriceTextController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
              left: PsDimens.space16,
              right: PsDimens.space16,
              top: PsDimens.space12),
          child: Text('home_search__price'.tr,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Utils.isLightMode(context) ? PsColors.text900 : PsColors.text300)),
        ),
        Container(
          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.all(PsDimens.space16),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 24,
                  height: PsDimens.space44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PsDimens.space4),
                    border: Border.all(color: PsColors.text200),
                  ),
                  child: TextField(
                    maxLines: null,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: PsDimens.space8, bottom: PsDimens.space8),
                      border: InputBorder.none,
                      hintText: 'Min'.tr,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              color: Utils.isLightMode(context) ? PsColors.text300 : PsColors.text600),
                    ),
                    keyboardType: TextInputType.number,
                    controller: minPriceTextController,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 24,
                  height: PsDimens.space44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PsDimens.space4),
                    border: Border.all(color: PsColors.text200),
                  ),
                  child: TextField(
                    maxLines: null,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: PsDimens.space8, bottom: PsDimens.space8),
                      border: InputBorder.none,
                      hintText: 'Max'.tr,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              color: Utils.isLightMode(context) ? PsColors.text300 : PsColors.text600),
                    ),
                    keyboardType: TextInputType.number,
                    controller: maxPriceTextController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
