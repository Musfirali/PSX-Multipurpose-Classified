import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';

import '../../../vendor/provider/language/app_localization_provider.dart';
import '../../../vendor/viewobject/item_location.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/product_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class SearchProductProvider extends PsProvider<Product> {
  SearchProductProvider({
    required ProductRepository? repo,
    this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsValueHolder? psValueHolder;
  PsResource<List<Product>> get productList => super.dataList;

  bool needReset = true;

  late ProductParameterHolder productParameterHolder;

  bool isSwitchedFeaturedProduct = false;
  bool isSwitchedDiscountPrice = false;

  String? selectedCategoryName = '';
  String? selectedSubCategoryName = '';
  String? selectedItemTypeName = '';
  String? selectedItemConditionName = '';
  String? selectedItemPriceTypeName = '';
  String? selectedItemDealOptionName = '';
  String? selectedItemIsSoldOut = '';
  String? selectedLocationName = '';
  String? selectedLocationTownshipName = '';

  String? categoryId = '';
  String? subCategoryId = '';
  String? itemTypeId = 'product_list__category_all'.tr; //default
  String? itemConditionId = '';
  String? itemPriceTypeId = '';
  String? itemDealOptionId = '';
  String? itemIsSoldOut = '';
  String? locationId = '';
  String? locationTownshipId = '';

  bool isfirstRatingClicked = false;
  bool isSecondRatingClicked = false;
  bool isThirdRatingClicked = false;
  bool isfouthRatingClicked = false;
  bool isFifthRatingClicked = false;

  void onCityDataChoose(dynamic locationResult) {
    if (locationResult != null && locationResult is ItemLocation) {
      locationId = locationResult.id;
      locationTownshipId = '';
      selectedLocationName = locationResult.name;
      selectedLocationTownshipName = 'product_list__category_all'.tr;
    } else if (locationResult) {
      locationId = '';
      selectedLocationName = 'product_list__category_all'.tr;
      locationTownshipId = '';
      selectedLocationTownshipName = 'product_list__category_all'.tr;
    }
    notifyListeners();
  }

  void clearData() {
    locationId = '';
    locationTownshipId = '';

    itemIsSoldOut = '';

    productParameterHolder.itemLocationId = '';
    selectedLocationName = 'product_list__category_all'.tr;
    productParameterHolder.itemLocationTownshipId = '';
    selectedLocationTownshipName = 'product_list__category_all'.tr;

    productParameterHolder.isSoldOut = '';
    productParameterHolder.productRelation?.clear();
    notifyListeners();
  }
}

SingleChildWidget initSearchProductProvider(
    BuildContext context, Function function,
    {Widget? widget, required ProductParameterHolder? productParameterHolder}) {
  final ProductRepository repo = Provider.of<ProductRepository>(context);
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  return psInitProvider<SearchProductProvider>(initProvider: () {
    return SearchProductProvider(
        repo: repo,
        psValueHolder: valueHolder,
        limit: valueHolder.defaultLoadingLimit!);
  }, onProviderReady: (SearchProductProvider provider) {
    function(provider);
    if (productParameterHolder!.itemLocationId == '') {
      productParameterHolder.itemLocationId = valueHolder.locationId;
      productParameterHolder.itemLocationName = valueHolder.locactionName;
      if (valueHolder.isSubLocation == PsConst.ONE &&
          productParameterHolder.itemLocationTownshipId == '') {
        productParameterHolder.itemLocationTownshipId =
            valueHolder.locationTownshipId;
        productParameterHolder.itemLocationTownshipName =
            valueHolder.locationTownshipName;
      }
    }
   productParameterHolder.mile = valueHolder.mile;
    final String? loginUserId = Utils.checkUserLoginId(valueHolder);
    provider.loadDataList(
      requestPathHolder: RequestPathHolder(
          loginUserId: loginUserId, languageCode: valueHolder.languageCode),
      requestBodyHolder: productParameterHolder,
    );
    // _searchProductProvider = provider;
    provider.productParameterHolder = productParameterHolder;
    // if (widget.appBarTitle == 'home_search__app_bar_title'.tr)
    //   _searchProductProvider.needReset = false;
    print(
        'ProductParameterHolder:: ${provider.productParameterHolder.toString()}');
    return provider;
  });
}

SingleChildWidget initSearchNearestProductProvider(
    BuildContext context, Function function,
    {Widget? widget, required ProductParameterHolder? productParameterHolder}) {
  final ProductRepository repo = Provider.of<ProductRepository>(context);
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  return psInitProvider<SearchProductProvider>(initProvider: () {
    return SearchProductProvider(
        repo: repo,
        psValueHolder: valueHolder,
        limit: valueHolder.defaultLoadingLimit!);
  }, onProviderReady: (SearchProductProvider provider) {
    function(provider);
    final String? loginUserId = Utils.checkUserLoginId(valueHolder);
    provider.loadDataList(
      requestPathHolder: RequestPathHolder(
          loginUserId: loginUserId, languageCode: valueHolder.languageCode),
      requestBodyHolder: productParameterHolder,
    );
    // _searchProductProvider = provider;
    provider.productParameterHolder = productParameterHolder!;
    // if (widget.appBarTitle == 'home_search__app_bar_title'.tr)
    //   _searchProductProvider.needReset = false;
    print(
        'ProductParameterHolder:: ${provider.productParameterHolder.toString()}');
    return provider;
  });
}