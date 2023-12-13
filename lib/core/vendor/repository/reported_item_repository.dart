import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/reported_item_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/reported_item.dart';
import 'Common/ps_repository.dart';

class ReportedItemRepository extends PsRepository {
  ReportedItemRepository(
      {required PsApiService psApiService,
      required ReportedItemDao reportedItemDao}) {
    _psApiService = psApiService;
    _itemTypeDao = reportedItemDao;
  }

  late PsApiService _psApiService;
  late ReportedItemDao _itemTypeDao;
  final String _primaryKey = 'id';

  Future<dynamic> insert(ReportedItem itemType) async {
    return _itemTypeDao.insert(_primaryKey, itemType);
  }

  Future<dynamic> update(ReportedItem itemType) async {
    return _itemTypeDao.update(itemType);
  }

  Future<dynamic> delete(ReportedItem itemType) async {
    return _itemTypeDao.delete(itemType);
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
      dao: _itemTypeDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getReportedItemList(
          requestPathHolder?.loginUserId, limit, offset),
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
      dao: _itemTypeDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () => _psApiService.getReportedItemList(
          requestPathHolder?.loginUserId, limit, offset),
    );
  }
}
