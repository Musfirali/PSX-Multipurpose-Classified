import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class CategoryIconWidget extends StatelessWidget {
  const CategoryIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchProductProvider searchProductProvider =
        Provider.of<SearchProductProvider>(context);

    return InkWell(
      onTap: () async {
        final Map<String, String?> dataHolder = <String, String?>{};
        dataHolder[PsConst.CATEGORY_ID] =
            searchProductProvider.productParameterHolder.catId;
        dataHolder[PsConst.SUB_CATEGORY_ID] =
            searchProductProvider.productParameterHolder.subCatId;
        final dynamic result = await Navigator.pushNamed(
            context, RoutePaths.categoryFilterList,
            arguments: dataHolder);

        if (result != null && result is Map<String, String?>) {
          searchProductProvider.productParameterHolder.catId =
              result[PsConst.CATEGORY_ID];

          searchProductProvider.productParameterHolder.subCatId =
              result[PsConst.SUB_CATEGORY_ID];

          searchProductProvider.loadDataList(reset: true);
        }
      },
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.category_outlined,
            size: PsDimens.space16,
          ),
          const SizedBox(
            width: PsDimens.space6,
          ),
          Text('search__category'.tr,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  color:
                      searchProductProvider.productParameterHolder.catId == ''
                          ? Utils.isLightMode(context) ? PsColors.text700: PsColors.text50
                          : Utils.isLightMode(context) ? PsColors.primary500: PsColors.primary300,)),
        ],
      ),
    );
  }
}
