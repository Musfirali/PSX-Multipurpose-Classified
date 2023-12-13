import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/item_loacation_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/item_location.dart';
import 'Common/ps_repository.dart';

class ItemLocationRepository extends PsRepository {
  ItemLocationRepository(
      {required PsApiService psApiService,
      required ItemLocationDao itemLocationDao}) {
    _psApiService = psApiService;
    _itemLocationDao = itemLocationDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late ItemLocationDao _itemLocationDao;

  Future<dynamic> insert(ItemLocation itemLocation) async {
    return _itemLocationDao.insert(primaryKey, itemLocation);
  }

  Future<dynamic> update(ItemLocation itemLocation) async {
    return _itemLocationDao.update(itemLocation);
  }

  Future<dynamic> delete(ItemLocation itemLocation) async {
    return _itemLocationDao.delete(itemLocation);
  }

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
      dao: _itemLocationDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getItemLocationList(
          requestBodyHolder!.toMap(),
          requestPathHolder!.loginUserId,
          limit,
          offset,
          requestPathHolder.languageCode ?? 'en'),
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
    await startResourceSinkingForNextList(
      dao: _itemLocationDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () => _psApiService.getItemLocationList(
          requestBodyHolder!.toMap(),
          requestPathHolder!.loginUserId,
          limit,
          offset,
          requestPathHolder.languageCode ?? 'en'),
    );
  }
}
