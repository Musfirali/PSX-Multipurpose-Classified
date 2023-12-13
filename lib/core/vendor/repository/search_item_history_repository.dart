import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/search_item_history_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/search_item_history.dart';
import 'Common/ps_repository.dart';

class SearchItemHistoryRepository extends PsRepository {
  SearchItemHistoryRepository(
      {required PsApiService psApiService,
      required SearchItemHistoryDao searchItemHistoryDao}) {
    _psApiService = psApiService;
    _searchCategoryHistoryDao = searchItemHistoryDao;
  }

  String primaryKey = 'id';
  late SearchItemHistoryDao _searchCategoryHistoryDao;
  late PsApiService _psApiService;

  Future<dynamic> insert(SearchItemHistory searchItemHistory) async {
    return _searchCategoryHistoryDao.insert(primaryKey, searchItemHistory);
  }

  Future<dynamic> update(SearchItemHistory searchItemHistory) async {
    return _searchCategoryHistoryDao.update(searchItemHistory);
  }

  Future<dynamic> delete(SearchItemHistory searchItemHistory) async {
    return _searchCategoryHistoryDao.delete(searchItemHistory);
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
      dao: _searchCategoryHistoryDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getSearchItemHistoryList(
        requestPathHolder?.loginUserId ?? 'nologinuser',
        requestPathHolder!.languageCode ?? 'en',
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
    await startResourceSinkingForNextList(
      dao: _searchCategoryHistoryDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () => _psApiService.getSearchItemHistoryList(
        requestPathHolder?.loginUserId ?? 'nologinuser',
        requestPathHolder!.languageCode ?? 'en',
        limit, 
        offset),
    );
  }

  Future<PsResource<ApiStatus>> deleteSearchItemHistoryList(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      String? languageCode,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource = await _psApiService
        .deleteSearchItemHistoryList(jsonMap, loginUserId!, languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
