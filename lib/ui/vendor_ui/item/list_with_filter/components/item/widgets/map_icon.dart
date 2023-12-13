import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';

class MapIconWidget extends StatelessWidget {
  const MapIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchProductProvider searchProductProvider =
        Provider.of<SearchProductProvider>(context);
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

    return InkWell(
      onTap: () async {
        if (valueHolder.isSubLocation == PsConst.ONE &&
            searchProductProvider.psValueHolder!.locationTownshipLat != '') {
          if (searchProductProvider.productParameterHolder.lat == '' &&
              searchProductProvider.productParameterHolder.lng == '') {
            searchProductProvider.productParameterHolder.lat =
                searchProductProvider.psValueHolder!.locationTownshipLat;
            searchProductProvider.productParameterHolder.lng =
                searchProductProvider.psValueHolder!.locationTownshipLng;
          }
        } else {
          if (searchProductProvider.productParameterHolder.lat == '' &&
              searchProductProvider.productParameterHolder.lng == '') {
            searchProductProvider.productParameterHolder.lat =
                searchProductProvider.psValueHolder!.locationLat;
            searchProductProvider.productParameterHolder.lng =
                searchProductProvider.psValueHolder!.locationLng;
          }
        }
        if (valueHolder.isUseGoogleMap!) {
          final dynamic result = await Navigator.pushNamed(
              context, RoutePaths.googleMapFilter,
              arguments: searchProductProvider.productParameterHolder);
          if (result != null && result is ProductParameterHolder) {
            searchProductProvider.productParameterHolder = result;

            /// The mile should not be less than 0.5km
            /// To prevent this, we need to check it's less than or not
            if (searchProductProvider.productParameterHolder.mile != null &&
                searchProductProvider.productParameterHolder.mile != '' &&
                double.parse(
                        searchProductProvider.productParameterHolder.mile!) <
                    1) {
              searchProductProvider.productParameterHolder.mile = '1';
            }
            searchProductProvider.loadDataList(reset: true);
          }
        } else {
          final dynamic result = await Navigator.pushNamed(
              context, RoutePaths.mapFilter,
              arguments: searchProductProvider.productParameterHolder);
          if (result != null && result is ProductParameterHolder) {
            searchProductProvider.productParameterHolder = result;
            if (searchProductProvider.productParameterHolder.mile != null &&
                searchProductProvider.productParameterHolder.mile != '' &&
                double.parse(
                        searchProductProvider.productParameterHolder.mile!) <
                    1) {
              searchProductProvider.productParameterHolder.mile = PsConst.ONE;
            }
            searchProductProvider.loadDataList(reset: true);
          }
        }
      },
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.gps_fixed,
            size: PsDimens.space16,
          ),
          const SizedBox(
            width: PsDimens.space6,
          ),
          Text(
            'search__map'.tr,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: searchProductProvider.productParameterHolder.lat == '' &&
                        searchProductProvider.productParameterHolder.lng == ''
                    ? Utils.isLightMode(context) ? PsColors.text700: PsColors.text50
                          : Utils.isLightMode(context) ? PsColors.primary500: PsColors.primary300,),
          ),
        ],
      ),
    );
  }
}
