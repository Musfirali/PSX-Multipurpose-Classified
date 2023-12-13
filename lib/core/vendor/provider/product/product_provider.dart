import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/add_on.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/basket_selected_add_on.dart';
import '../../viewobject/basket_selected_attribute.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/core_field.dart';
import '../../viewobject/customized_detail.dart';
import '../../viewobject/product.dart';
import '../../viewobject/user.dart';
import '../common/ps_provider.dart';

class ItemDetailProvider extends PsProvider<Product> {
  ItemDetailProvider({
    required ProductRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  ProductRepository? _repo;
  PsValueHolder? psValueHolder;
  PsResource<Product> get itemDetail => super.data;

  //e commerce
  Map<String, CustomizedDetail> selectedcustomizedDetailMapList =
      <String, CustomizedDetail>{};
  Map<AddOn, bool> selectedAddOnMapList = <AddOn, bool>{};
  BasketSelectedAddOn basketSelectedAddOn = BasketSelectedAddOn();
  BasketSelectedAttribute basketSelectedAttribute = BasketSelectedAttribute();

  int quantity = 0;
  double selectedAddOnPrice = 0.0;
  double selectedCustomizedPrice = 0.0;

  CoreField titleCoreField = CoreField(visible: '1');

  void addIntentAddOnList(
      List<BasketSelectedAddOn>? intentBasketSelectedAddOnList) {
    if (intentBasketSelectedAddOnList != null) {
      for (BasketSelectedAddOn obj in intentBasketSelectedAddOnList) {
        selectedAddOnMapList[
            AddOn(id: obj.id, name: obj.name, price: obj.price)] = true;
        basketSelectedAddOn.addAddOn(obj);
        if (obj.price != null && obj.price != '')
          selectedAddOnPrice += double.parse(obj.price!);
      }
    }
  }

  void addIntentCustomizedList(
      List<BasketSelectedAttribute>? intentBasketSelectedAttributeList) {
    if (intentBasketSelectedAttributeList != null) {
      for (BasketSelectedAttribute obj in intentBasketSelectedAttributeList) {
        selectedcustomizedDetailMapList[obj.headerId!] = CustomizedDetail(
            id: obj.id,
            headerId: obj.headerId,
            name: obj.name,
            additionalPrice: obj.price);
        basketSelectedAttribute.addAttribute(obj);
        if (obj.price != null && obj.price != '') {
          selectedCustomizedPrice += double.parse(obj.price!);
        }
      }
    }
  }

  void addAddOn(AddOn addOn) {
    basketSelectedAddOn.addAddOn(basketSelectedAddOn.fromAddOn(
        addOn, product.itemCurrency?.currencySymbol));
    selectedAddOnPrice += double.tryParse(addOn.price ?? '') ?? 0.0;
    notifyListeners();
  }

  void subtractAddOn(AddOn addOn) {
    basketSelectedAddOn.subAddOn(basketSelectedAddOn.fromAddOn(
        addOn, product.itemCurrency?.currencySymbol));
    selectedAddOnPrice -= double.tryParse(addOn.price ?? '') ?? 0.0;
    notifyListeners();
  }

  void addCustomizedDetail(CustomizedDetail customizedDetail) {
    basketSelectedAttribute.addAttribute(
        basketSelectedAttribute.fromCustomizedDetail(
            customizedDetail, product.itemCurrency?.currencySymbol));
    selectedCustomizedPrice +=
        double.tryParse(customizedDetail.additionalPrice ?? '') ?? 0.0;
    notifyListeners();
  }

  void subtractCustomizedDetailPrice(String? price) {
    selectedCustomizedPrice -= double.tryParse(price ?? '') ?? 0.0;
    notifyListeners();
  }

  String get totalPrice {
    if (product.isDiscountedItem) {
      return (double.parse(product.currentPrice!) +
              selectedAddOnPrice +
              selectedCustomizedPrice)
          .toString();
    }
    return (double.parse(product.originalPrice!) +
            selectedAddOnPrice +
            selectedCustomizedPrice)
        .toString();
  }

  String get totalOriginalPrice {
    return (double.parse(product.originalPrice!) +
            selectedAddOnPrice +
            selectedCustomizedPrice)
        .toString();
  }

  Product get product {
    return itemDetail.data ?? Product();
  }

  User? get productOwner {
    if (itemDetail.data == null || itemDetail.data!.user == null)
      return null;
    else
      return itemDetail.data!.user;
  }

  void updateProduct(Product product) {
    super.data.data = product;
    notifyListeners();
  }

  Future<void> deleteLocalProductCacheById(
    String? productId,
    String? loginUserId,
  ) async {
    isLoading = true;
    isConnectedToInternet = await Utils.checkInternetConnectivity();

    await _repo!.deleteLocalProductCacheById(
        super.dataStreamController,
        productId,
        loginUserId,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING);

    isLoading = false;
  }

  Future<void> deleteLocalProductCacheByUserId(
    String? loginUserId,
    String? addedUserId,
  ) async {
    isLoading = true;
    isConnectedToInternet = await Utils.checkInternetConnectivity();

    await _repo!.deleteLocalProductCacheByUserId(
        super.dataStreamController,
        loginUserId,
        addedUserId,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING);

    isLoading = false;
  }

  Future<PsResource<ApiStatus>> userDeleteItem(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String languageCode, String itemId) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.userDeleteItem(
        jsonMap,
        loginUserId,
        itemId,
        psValueHolder!.headerToken!,
        languageCode,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING);
  }

  Future<PsResource<Product>> changeItemStatus(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String languageCode, String itemId) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.changeItemStatus(
        jsonMap,
        loginUserId,
        itemId,
        psValueHolder!.headerToken!,
        languageCode,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING);
  }
}

SingleChildWidget initItemDetailProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
  String? productID,
}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  final ProductRepository productRepo = Provider.of<ProductRepository>(context);
  return psInitProvider<ItemDetailProvider>(
      widget: widget,
      initProvider: () =>
          ItemDetailProvider(repo: productRepo, psValueHolder: valueHolder),
      onProviderReady: (ItemDetailProvider provider) {
        final String? loginUserId = Utils.checkUserLoginId(valueHolder);
        provider.loadData(
          requestPathHolder: RequestPathHolder(
            itemId: productID,
            loginUserId: loginUserId,
            languageCode: valueHolder.languageCode,
          ),
        );
        function(provider);
      });
}
