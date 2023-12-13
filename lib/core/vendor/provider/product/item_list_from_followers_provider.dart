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
import '../../viewobject/holder/follower_uer_item_list_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class ItemListFromFollowersProvider extends PsProvider<Product> {
  ItemListFromFollowersProvider({
    required ProductRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }
  FollowUserItemParameterHolder followUserItemParameterHolder =
      FollowUserItemParameterHolder().getLatestParameterHolder();

  ProductRepository? _repo;
  PsValueHolder? psValueHolder;

  PsResource<List<Product>> get itemListFromFollowersList => super.dataList;

  Future<dynamic> loadItemListFromFollowersList({
    required Map<dynamic, dynamic> jsonMap,
    required String? loginUserId,
    required String? languageCode,
    DataConfiguration? dataConfig,
  }) async {
    isLoading = true;
    final DataConfiguration defaultDataConfig =
        await super.getDefaultDataConfig;
    await _repo!.getAllItemListFromFollower(
      super.dataListStreamController,
      jsonMap,
      loginUserId,
      limit,
      offset,
      PsStatus.PROGRESS_LOADING,
      languageCode!,
      dataConfig ?? defaultDataConfig,
    );
  }

  Future<dynamic> nextItemListFromFollowersList({
    required Map<dynamic, dynamic> jsonMap,
    required String? loginUserId,
    required String? languageCode,
    DataConfiguration? dataConfig,
  }) async {
    isConnectedToInternet = await Utils.checkInternetConnectivity();
    final DataConfiguration defaultDataConfig =
        await super.getDefaultDataConfig;
    if (!isLoading && !isReachMaxData) {
      super.isLoading = true;
      await _repo!.getNextPageItemListFromFollower(
        super.dataListStreamController,
        jsonMap,
        loginUserId!,
        limit,
        offset,
        PsStatus.PROGRESS_LOADING,
        languageCode!,
        dataConfig ?? defaultDataConfig,
      );
    }
  }

  Future<void> resetItemListFromFollowersList({
    required Map<dynamic, dynamic> jsonMap,
    required String? loginUserId,
    required String? languageCode,
    DataConfiguration? dataConfig,
  }) async {
    isConnectedToInternet = await Utils.checkInternetConnectivity();
    isLoading = true;

    updateOffset(0);
    final DataConfiguration defaultDataConfig =
        await super.getDefaultDataConfig;
    await _repo!.getAllItemListFromFollower(
      super.dataListStreamController,
      jsonMap,
      loginUserId,
      limit,
      offset,
      PsStatus.PROGRESS_LOADING,
      languageCode!,
      dataConfig ?? defaultDataConfig,
    );

    isLoading = false;
  }

  bool get hasLoginUserId {
    return psValueHolder != null &&
        psValueHolder!.loginUserId != null &&
        psValueHolder!.loginUserId != '';
  }
}

SingleChildWidget initItemListFromFollowersProvider(
    BuildContext context, Function function,
    {Widget? widget}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  final ProductRepository repo = Provider.of<ProductRepository>(context);
  // final AppLocalization langProvider = Provider.of<AppLocalization>(context);
  return psInitProvider<ItemListFromFollowersProvider>(
      widget: widget,
      initProvider: () {
        return ItemListFromFollowersProvider(
            repo: repo,
            psValueHolder: valueHolder,
            limit: valueHolder.followerItemLoadingLimit!);
      },
      onProviderReady: (ItemListFromFollowersProvider provider) {
        provider.followUserItemParameterHolder.itemLocationId =
            valueHolder.locationId;
        if (valueHolder.isSubLocation == PsConst.ONE) {
          provider.followUserItemParameterHolder.itemLocationTownshipId =
              valueHolder.locationTownshipId;
        }
        provider.loadItemListFromFollowersList(
            jsonMap: provider.followUserItemParameterHolder.toMap(),
            loginUserId: Utils.checkUserLoginId(
              provider.psValueHolder,
            ),
            languageCode: valueHolder.languageCode);
        function(provider);
      });
}
