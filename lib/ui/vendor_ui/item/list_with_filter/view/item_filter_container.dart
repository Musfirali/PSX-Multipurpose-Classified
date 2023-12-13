import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../custom_ui/item/list_with_filter/components/filter/filter_view.dart';
import '../../../common/base/ps_widget_with_appbar.dart';

class ItemFilterContainer extends StatefulWidget {
  const ItemFilterContainer({
    required this.productParameterHolder,
  });

  final ProductParameterHolder productParameterHolder;

  @override
  _ItemFilterContainerState createState() => _ItemFilterContainerState();
}

class _ItemFilterContainerState extends State<ItemFilterContainer> {
  late ProductRepository repo;
  late SearchProductProvider _searchProductProvider;

  final TextEditingController _itemNameTextController = TextEditingController();
  final TextEditingController _maxPriceTextController = TextEditingController();
  final TextEditingController _minPriceTextController = TextEditingController();

  String? orderByFirstValue = '';
  bool isAllLocationSelected = false;

  void _handleReset() {
    _itemNameTextController.text = '';
    _maxPriceTextController.text = '';
    _minPriceTextController.text = '';
    _searchProductProvider.productParameterHolder.orderBy = orderByFirstValue;
    _searchProductProvider.clearData();
  }

  void _handleApply() {
    if (_itemNameTextController.text.isNotEmpty) {
      _searchProductProvider.productParameterHolder.searchTerm =
          _itemNameTextController.text;
    } else {
      _searchProductProvider.productParameterHolder.searchTerm = '';
    }

    if (_maxPriceTextController.text.isNotEmpty) {
      _searchProductProvider.productParameterHolder.maxPrice =
          _maxPriceTextController.text;
    } else {
      _searchProductProvider.productParameterHolder.maxPrice = '';
    }

    if (_minPriceTextController.text.isNotEmpty) {
      _searchProductProvider.productParameterHolder.minPrice =
          _minPriceTextController.text;
    } else {
      _searchProductProvider.productParameterHolder.minPrice = '';
    }

    _searchProductProvider.productParameterHolder.itemLocationId =
        _searchProductProvider.locationId;
    _searchProductProvider.productParameterHolder.itemLocationName =
        _searchProductProvider.selectedLocationName;
    _searchProductProvider.productParameterHolder.itemLocationTownshipId =
        _searchProductProvider.locationTownshipId;
    _searchProductProvider.productParameterHolder.itemLocationTownshipName =
        _searchProductProvider.selectedLocationTownshipName;
    if (_searchProductProvider.itemIsSoldOut != null) {
      _searchProductProvider.productParameterHolder.isSoldOut =
          _searchProductProvider.itemIsSoldOut;
    }
    Navigator.pop(context, _searchProductProvider.productParameterHolder);
  }

  @override
  Widget build(BuildContext context) {
    repo = Provider.of<ProductRepository>(context);

    return PsWidgetWithAppBar<SearchProductProvider>(
        appBarTitle: 'search__filter'.tr,
        initProvider: () {
          return SearchProductProvider(repo: repo);
        },
        onProviderReady: (SearchProductProvider provider) {
          _searchProductProvider = provider;
          _searchProductProvider.productParameterHolder =
              widget.productParameterHolder;
          _searchProductProvider.locationId =
              widget.productParameterHolder.itemLocationId;
          _searchProductProvider.locationTownshipId =
              widget.productParameterHolder.itemLocationTownshipId;
          _searchProductProvider.selectedLocationName =
              widget.productParameterHolder.itemLocationName;
          _searchProductProvider.selectedLocationTownshipName =
              widget.productParameterHolder.itemLocationTownshipName;

          orderByFirstValue =
              _searchProductProvider.productParameterHolder.orderBy;

          _itemNameTextController.text =
              widget.productParameterHolder.searchTerm!;
        },
        builder: (BuildContext context, SearchProductProvider provider,
            Widget? child) {
          return CustomFilterView(
            handleApply: _handleApply,
            handleReset: _handleReset,
            maxPriceTextController: _maxPriceTextController,
            minPriceTextController: _minPriceTextController,
          );
        });
  }
}
