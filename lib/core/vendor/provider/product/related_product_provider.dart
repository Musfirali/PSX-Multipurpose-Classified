import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../db/common/ps_data_source_manager.dart';
import '../../repository/product_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class RelatedProductProvider extends PsProvider<Product> {
  RelatedProductProvider({
    required ProductRepository repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
    //   dataList.data = Product().checkDuplicate(dataList.data!);
    // notifyListeners();
  }

  PsValueHolder psValueHolder;
  late ProductRepository _repo;

  PsResource<List<Product>> get relatedProductList => super.dataList;

  Future<dynamic> loadRelatedProductList({
    required String? loginUserId,
    String? languageCode,
    required String? productId,
    required String? categoryId,
    DataConfiguration? dataConfiguration,
  }) async {
    isLoading = true;
    isConnectedToInternet = await Utils.checkInternetConnectivity();
    final DataConfiguration defaultDataConfig =
        await super.getDefaultDataConfig;
    await _repo.getRelatedProductList(
      super.dataListStreamController,
      productId!,
      categoryId!,
      loginUserId!,
      languageCode,
      isConnectedToInternet,
      limit,
      offset,
      dataConfiguration ?? defaultDataConfig,
    );
  }

  Future<dynamic> loadNextRelatedProductList({
    required String? loginUserId,
    String? languageCode,
    required String? productId,
    required String? categoryId,
    DataConfiguration? dataConfig,
  }) async {
    if (!isLoading && !isReachMaxData) {
      super.isLoading = true;
      final DataConfiguration defaultDataConfig =
          await super.getDefaultDataConfig;
      await _repo.getNextPageRelatedProductList(
        super.dataListStreamController,
        productId!,
        categoryId!,
        loginUserId!,
        languageCode,
        limit,
        offset,
        PsStatus.PROGRESS_LOADING,
        dataConfig ?? defaultDataConfig,
      );
    }
  }

  Future<void> resetRelatedItemList({
    required String? loginUserId,
    String? languageCode,
    required String? productId,
    required String? categoryId,
    DataConfiguration? dataConfig,
  }) async {
    isLoading = true;

    updateOffset(0);
    final DataConfiguration defaultDataConfig =
        await super.getDefaultDataConfig;
    await _repo.getRelatedProductList(
      super.dataListStreamController,
      productId!,
      categoryId!,
      loginUserId!,
      languageCode,
      isConnectedToInternet,
      limit,
      offset,
      dataConfig ?? defaultDataConfig,
    );

    isLoading = false;
  }
}

SingleChildWidget initRelatedProductProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
  // String? catID,
  String? productID,
}) {
  final ProductRepository repo = Provider.of<ProductRepository>(context);
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  return psInitProvider<RelatedProductProvider>(initProvider: () {
    return RelatedProductProvider(repo: repo, psValueHolder: valueHolder);
  }, onProviderReady: (RelatedProductProvider pro) {
    // pro.loadRelatedProductList(
    //     dataConfiguration:
    //         DataConfiguration(dataSourceType: DataSourceType.SERVER_DIRECT),
    //     productId: productID,
    //     categoryId: catID,
    //     loginUserId: Utils.checkUserLoginId(valueHolder),
    //     languageCode: valueHolder.languageCode);
    function(pro);
  });
}
