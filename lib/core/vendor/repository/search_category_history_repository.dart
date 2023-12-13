import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/search_category_history_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/search_category_history.dart';
import 'Common/ps_repository.dart';

class SearchCategoryHistoryRepository extends PsRepository {
  SearchCategoryHistoryRepository(
      {required PsApiService psApiService,
      required SearchCategoryHistoryDao searchCategoryHistoryDao}) {
    _psApiService = psApiService;
    _searchCategoryHistoryDao = searchCategoryHistoryDao;
  }

  String primaryKey = 'id';
  late SearchCategoryHistoryDao _searchCategoryHistoryDao;
  late PsApiService _psApiService;

  Future<dynamic> insert(SearchCategoryHistory searchCategoryHistory) async {
    return _searchCategoryHistoryDao.insert(primaryKey, searchCategoryHistory);
  }

  Future<dynamic> update(SearchCategoryHistory searchCategoryHistory) async {
    return _searchCategoryHistoryDao.update(searchCategoryHistory);
  }

  Future<dynamic> delete(SearchCategoryHistory searchCategoryHistory) async {
    return _searchCategoryHistoryDao.delete(searchCategoryHistory);
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
      serverRequestCallback: () => _psApiService.getSearchCategoryHistoryList(
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
      serverRequestCallback: () => _psApiService.getSearchCategoryHistoryList(
        requestPathHolder?.loginUserId ?? 'nologinuser',
        requestPathHolder!.languageCode ?? 'en',
        limit, 
        offset),
    );
  }

  Future<PsResource<ApiStatus>> deleteSearchCategoryHistoryList(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      String? languageCode,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource = await _psApiService
        .deleteSearchCategoryHistoryList(jsonMap, loginUserId!, languageCode ?? 'en');
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
