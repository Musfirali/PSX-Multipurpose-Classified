import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class SortingRadioView extends StatefulWidget {
  const SortingRadioView({
    required this.searchProductProvider,
  });

  final SearchProductProvider searchProductProvider;

  @override
  State<StatefulWidget> createState() => _SortingRadioViewState();
}

class _SortingRadioViewState extends State<SortingRadioView> {
  dynamic updateSorting(String orderBy, String orderType) {
    setState(() {
      widget.searchProductProvider.productParameterHolder.orderBy = orderBy;
      widget.searchProductProvider.productParameterHolder.orderType = orderType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: PsDimens.space16, right: PsDimens.space16),
          child: Text('filter__sorting'.tr,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Utils.isLightMode(context) ? PsColors.text900 : PsColors.text300)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const SizedBox(
              width: PsDimens.space8,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Radio<String?>(
                    value: widget
                        .searchProductProvider.productParameterHolder.orderBy,
                    groupValue: PsConst.FILTERING__ADDED_DATE,
                    onChanged: (String? name) {
                      updateSorting(PsConst.FILTERING__ADDED_DATE,
                          PsConst.FILTERING__DESC);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                    child: Text(
                      'Recent'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Radio<String?>(
                    value: widget
                        .searchProductProvider.productParameterHolder.orderBy,
                    groupValue: PsConst.FILTERING_TRENDING,
                    onChanged: (String? name) {
                      updateSorting(
                          PsConst.FILTERING_TRENDING, PsConst.FILTERING__DESC);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                    child: Text(
                      'Popular'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
