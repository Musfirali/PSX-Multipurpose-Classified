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

class FavouriteItemProvider extends PsProvider<Product> {
  FavouriteItemProvider({
    required ProductRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;

    super.dataList.data = Product().checkDuplicate(dataList.data!);
    notifyListeners();
  }

  ProductRepository? _repo;
  PsValueHolder? psValueHolder;

  PsResource<List<Product>> get favouriteItemList => super.dataList;

  Future<dynamic> loadFavouriteItemList(String languageCode,
      {DataConfiguration? dataConfig}) async {
    isLoading = true;
    final DataConfiguration defaultDataConfig =
        await super.getDefaultDataConfig;
    await _repo!.getAllFavouritesList(
      super.dataListStreamController,
      psValueHolder!.loginUserId,
      psValueHolder!.headerToken,
      languageCode,
      limit,
      offset,
      PsStatus.PROGRESS_LOADING,
      dataConfig ?? defaultDataConfig,
    );
  }

  Future<dynamic> nextFavouriteItemList(String languageCode,
      {DataConfiguration? dataConfig}) async {
    if (!isLoading && !isReachMaxData) {
      super.isLoading = true;
      final DataConfiguration defaultDataConfig =
          await super.getDefaultDataConfig;
      await _repo!.getNextPageFavouritesList(
        super.dataListStreamController,
        psValueHolder!.loginUserId,
        psValueHolder!.headerToken,
        languageCode,
        limit,
        offset,
        PsStatus.PROGRESS_LOADING,
        dataConfig ?? defaultDataConfig,
      );
    }
  }

  Future<void> resetFavouriteItemList(String languageCode,
      {DataConfiguration? dataConfig}) async {
    isLoading = true;

    updateOffset(0);
    final DataConfiguration defaultDataConfig =
        await super.getDefaultDataConfig;
    await _repo!.getAllFavouritesList(
      super.dataListStreamController,
      psValueHolder!.loginUserId,
      psValueHolder!.headerToken,
      languageCode,
      limit,
      offset,
      PsStatus.PROGRESS_LOADING,
      dataConfig ?? defaultDataConfig,
    );

    isLoading = false;
  }

  Future<dynamic> postFavourite(
    Map<dynamic, dynamic> jsonMap,
    String loginUserId,
    String headerToken,
    String? languageCode,
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    return await _repo!.postFavourite(jsonMap, isConnectedToInternet,
        PsStatus.PROGRESS_LOADING, loginUserId, headerToken, languageCode);
  }
}

SingleChildWidget initFavouriteItemProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
}) {
  final ProductRepository repo = Provider.of<ProductRepository>(context);
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  return psInitProvider<FavouriteItemProvider>(
      initProvider: () =>
          FavouriteItemProvider(repo: repo, psValueHolder: valueHolder),
      onProviderReady: (FavouriteItemProvider pro) {
        function(pro);
      });
}
