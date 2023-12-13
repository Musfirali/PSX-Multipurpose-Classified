import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/product_collection_dao.dart';
import '../db/product_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/product_collection.dart';
import 'Common/ps_repository.dart';

class ProductByCollectionIdRepository extends PsRepository {
  ProductByCollectionIdRepository(
      {required PsApiService psApiService, required ProductDao productDao}) {
    _psApiService = psApiService;
    _productDao = productDao;
  }

  late PsApiService _psApiService;
  late ProductDao _productDao;
  final String collectionKey = 'collection_key';
  final String primaryKey = 'id'; 

  @override
  Future<void> loadDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    final String paramKey = requestBodyHolder!.getParamKey();

    final ProductCollectionDao productCollectionDao =
        ProductCollectionDao.instance;
    await startResourceSinkingForListWithMap<ProductCollection>(
      mapDao: productCollectionDao,
      mapKey: collectionKey,
      mapObject: ProductCollection(),
      paramKey: paramKey,
      primaryKey: primaryKey,
      finder: Finder(
          filter:
              Filter.equals(collectionKey, requestPathHolder!.collectionId)),
      dao: _productDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getProductListByCollectionId(
          requestPathHolder.collectionId!,
          requestPathHolder.loginUserId!,
          limit,
          offset),
    );
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
    final String paramKey = requestBodyHolder!.getParamKey();

    final ProductCollectionDao productCollectionDao =
        ProductCollectionDao.instance;
    await startResourceSinkingForNextListWithMap<ProductCollection>(
      mapDao: productCollectionDao,
      mapKey: collectionKey,
      mapObject: ProductCollection(),
      paramKey: paramKey,
      primaryKey: primaryKey,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      finder: Finder(
          filter:
              Filter.equals(collectionKey, requestPathHolder!.collectionId)),
      dao: _productDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getProductListByCollectionId(
          requestPathHolder.collectionId!,
          requestPathHolder.loginUserId!,
          limit,
          offset),
    );
  }
}
