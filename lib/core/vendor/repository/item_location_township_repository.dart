import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/item_loacation_township_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/item_location_township.dart';
import 'Common/ps_repository.dart';

class ItemLocationTownshipRepository extends PsRepository {
  ItemLocationTownshipRepository(
      {required PsApiService psApiService,
      required ItemLocationTownshipDao itemLocationTownshipDao}) {
    _psApiService = psApiService;
    _itemLocationTownshipDao = itemLocationTownshipDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late ItemLocationTownshipDao _itemLocationTownshipDao;

  Future<dynamic> insert(ItemLocationTownship itemLocationTownship) async {
    return _itemLocationTownshipDao.insert(primaryKey, itemLocationTownship);
  }

  Future<dynamic> update(ItemLocationTownship itemLocationTownship) async {
    return _itemLocationTownshipDao.update(itemLocationTownship);
  }

  Future<dynamic> delete(ItemLocationTownship itemLocationTownship) async {
    return _itemLocationTownshipDao.delete(itemLocationTownship);
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
      dao: _itemLocationTownshipDao,
      streamController: streamController,
      dataConfig: dataConfig,
      finder: Finder(
          filter: Filter.equals('location_city_id', requestBodyHolder!.toMap()['city_id'])),
      serverRequestCallback: () => _psApiService.getItemLocationTownshipList(
        requestBodyHolder.toMap(),
        requestPathHolder!.loginUserId,
        limit,
        offset,
        requestPathHolder.languageCode ?? 'en'
      ),
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
      dao: _itemLocationTownshipDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      finder: Finder(
          filter: Filter.equals('location_city_id', requestBodyHolder!.toMap()['city_id'])),
      serverRequestCallback: () => _psApiService.getItemLocationTownshipList(
        requestBodyHolder.toMap(),
        requestPathHolder!.loginUserId,
        limit,
        offset,
        requestPathHolder.languageCode ?? 'en'
      ),
    );
  }
}
