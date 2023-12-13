import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/product_collection_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class ProductCollectionRepository extends PsRepository {
  ProductCollectionRepository(
      {required PsApiService psApiService,
      required ProductCollectionDao productCollectionDao}) {
    _psApiService = psApiService;
    _productCollectionDao = productCollectionDao;
  }

  late PsApiService _psApiService;
  late ProductCollectionDao _productCollectionDao;

  @override
  Future<void> loadDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForList(
        dao: _productCollectionDao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () {
          if (requestPathHolder!.shopId != null) {
            return _psApiService.getProductCollectionListByShopId(
                requestPathHolder.shopId!, limit, offset);
          } else {
            return _psApiService.getProductCollectionList(limit, offset);
          }
        });
  }

  @override
  Future<void> loadNextDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForNextList(
        dao: _productCollectionDao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () {
          if (requestPathHolder!.shopId != null) {
            return _psApiService.getProductCollectionListByShopId(
                requestPathHolder.shopId!, limit, offset);
          } else {
            return _psApiService.getProductCollectionList(limit, offset);
          }
        });
  }
}
