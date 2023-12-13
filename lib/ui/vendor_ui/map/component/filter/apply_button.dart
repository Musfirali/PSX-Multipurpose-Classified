import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton(
      {required this.kmValue,
      required this.productParameterHolder,
      required this.lat,
      required this.lng});
  final String kmValue;
  final ProductParameterHolder productParameterHolder;
  final String lat;
  final String lng;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    return Expanded(
      child: InkWell(
        onTap: () {
          if (kmValue == 'All') {
            productParameterHolder.lat = '';
            productParameterHolder.lng = '';
            productParameterHolder.mile = '';
            if (valueHolder.isSubLocation == PsConst.ONE) {
              productParameterHolder.itemLocationId = '';
            } else {
              productParameterHolder.itemLocationId = '';
              productParameterHolder.itemLocationTownshipId = '';
            }
          } else {
            productParameterHolder.lat = lat;
            productParameterHolder.lng = lng;
            productParameterHolder.mile = Utils.getMilesFromKilometer(kmValue);
          }
          Navigator.pop(context, productParameterHolder);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(PsDimens.space4),
          ),
          alignment: Alignment.center,
          height: 40,
          width: double.infinity,
          child: Text(
            'Apply'.tr,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Utils.isLightMode(context) ? PsColors.achromatic50: PsColors.text800, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
