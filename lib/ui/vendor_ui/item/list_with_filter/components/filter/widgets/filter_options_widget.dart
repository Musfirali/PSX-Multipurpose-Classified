import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/filter/widgets/location.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/filter/widgets/location_township.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/filter/widgets/price_arrange.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/filter/widgets/sorting.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/filter/widgets/status.dart';

class FilterOptionsWidget extends StatelessWidget {
  const FilterOptionsWidget({
    Key? key,
    required TextEditingController minPriceTextController,
    required TextEditingController maxPriceTextController,
  })  : _minPriceTextController = minPriceTextController,
        _maxPriceTextController = maxPriceTextController,
        super(key: key);

  final TextEditingController _minPriceTextController;
  final TextEditingController _maxPriceTextController;

  @override
  Widget build(BuildContext context) {
    final SearchProductProvider provider =
        Provider.of<SearchProductProvider>(context);
    final PsValueHolder _valueHolder = Provider.of<PsValueHolder>(context);

    return Column(
      children: <Widget>[
        CustomSortingRadioView(
          searchProductProvider: provider,
        ),
        CustomStatusRadioView(
          searchProductProvider: provider,
        ),
        CustomPriceArrangementWidget(
          minPriceTextController: _minPriceTextController,
          maxPriceTextController: _maxPriceTextController,
        ),
        const CustomLocationDropDownButton(),
        if (_valueHolder.isSubLocation == PsConst.ONE)
          const CustomLocationTownshipDownDownButton()
      ],
    );
  }
}
