import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';

class FilterIconWidget extends StatelessWidget {
  const FilterIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchProductProvider searchProductProvider =
        Provider.of<SearchProductProvider>(context);

    return InkWell(
      onTap: () async {
        final dynamic result = await Navigator.pushNamed(
            context, RoutePaths.itemSearch,
            arguments: searchProductProvider.productParameterHolder);
        if (result != null && result is ProductParameterHolder) {
          searchProductProvider.productParameterHolder = result;
          searchProductProvider.loadDataList(reset: true);
        }
      },
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.filter_alt_outlined,
            size: PsDimens.space16,
          ),
          const SizedBox(
            width: PsDimens.space6,
          ),
          Text(
            'search__filter'.tr,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: searchProductProvider.productParameterHolder.searchTerm == '' &&
                          searchProductProvider
                                  .productParameterHolder.maxPrice ==
                              '' &&
                          searchProductProvider
                                  .productParameterHolder.minPrice ==
                              '' &&
                          searchProductProvider
                                  .productParameterHolder.isSoldOut ==
                              '' &&
                          searchProductProvider
                                  .productParameterHolder.itemLocationId ==
                              '' &&
                          searchProductProvider.productParameterHolder
                                  .itemLocationTownshipId ==
                              '' &&
                          searchProductProvider
                              .productParameterHolder.productRelation!.isEmpty
                      ? Utils.isLightMode(context) ? PsColors.text700: PsColors.text50
                          : Utils.isLightMode(context) ? PsColors.primary500: PsColors.primary300,
                ),
          ),
        ],
      ),
    );
  }
}
