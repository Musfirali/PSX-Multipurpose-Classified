import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/search_history_dao.dart';
import '../db/search_history_map_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/search_history.dart';
import '../viewobject/search_history_map.dart';
import 'Common/ps_repository.dart';

class SearchHistoryRepository extends PsRepository {
  SearchHistoryRepository(
      {required PsApiService psApiService,
      required SearchHistoryDao searchHistoryDao}) {
    _psApiService = psApiService;
    _searchHistoryDao = searchHistoryDao;
  }

  String primaryKey = 'id';
  String mapKey = 'map_key';
  late SearchHistoryDao _searchHistoryDao;
  late PsApiService _psApiService;

  Future<dynamic> insert(SearchHistory history) async {
    return _searchHistoryDao.insert(primaryKey, history);
  }

  Future<dynamic> update(SearchHistory history) async {
    return _searchHistoryDao.update(history);
  }

  Future<dynamic> delete(SearchHistory history) async {
    return _searchHistoryDao.delete(history);
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
    final String paramKey = requestBodyHolder!.getParamKey();
    final SearchHistoryMapDao searchHistoryMapDao =
        SearchHistoryMapDao.instance;
    await startResourceSinkingForListWithMap<SearchHistoryMap>(
        mapObject: SearchHistoryMap(),
        mapDao: searchHistoryMapDao,
        dao: _searchHistoryDao,
        streamController: streamController,
        dataConfig: dataConfig,
        primaryKey: primaryKey,
        mapKey: mapKey,
        paramKey: paramKey,
        serverRequestCallback: () {
          return _psApiService.getSearchHistoryList(
            requestBodyHolder.toMap(),
            requestPathHolder!.loginUserId!,
            requestPathHolder.languageCode ?? 'en',
            limit,
            offset,
          );
        });

    // await subscribeDataListWithMap(
    //     dataListStream: streamController,
    //     primaryKey: primaryKey,
    //     mapKey: mapKey,
    //     mapObject: SearchHistoryMap(),
    //     paramKey: paramKey,
    //     dao: _searchHistoryDao,
    //     statusOnDataChange: PsStatus.PROGRESS_LOADING,
    //     dataConfig: dataConfig,
    //     mapDao: searchHistoryMapDao);
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
    final SearchHistoryMapDao productMapDao = SearchHistoryMapDao.instance;
    await startResourceSinkingForNextListWithMap<SearchHistoryMap>(
      mapObject: SearchHistoryMap(),
      mapDao: productMapDao,
      dao: _searchHistoryDao,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      streamController: streamController,
      dataConfig: dataConfig,
      primaryKey: primaryKey,
      mapKey: mapKey,
      paramKey: paramKey,
      serverRequestCallback: () => _psApiService.getSearchHistoryList(
        requestBodyHolder.toMap(),
        requestPathHolder!.loginUserId!,
        requestPathHolder.languageCode ?? 'en',
        limit,
        offset,
      ),
    );
  }

  Future<PsResource<ApiStatus>> deleteSearchHistoryList(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      String? languageCode,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource = await _psApiService
        .deleteSearchHistoryList(jsonMap, loginUserId!, languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  // @override
  // Future<void> loadDataListFromDatabase({
  //   required StreamController<PsResource<List<dynamic>>> streamController,
  //   PsHolder<dynamic>? requestBodyHolder,
  //   RequestPathHolder? requestPathHolder,
  // }) async {
  //   await startResourceSinkingForListFromDataBase(
  //     dao: _searchHistoryDao,
  //     streamController: streamController,
  //   );
  // }

  // @override
  // Future<void> insertToDatabase({
  //   required StreamController<PsResource<List<dynamic>>> streamController,
  //   required dynamic obj,
  // }) async {
  //   await insert(obj);
  //   await startResourceSinkingForListFromDataBase(
  //     dao: _searchHistoryDao,
  //     streamController: streamController,
  //   );
  // }

  // @override
  // Future<void> deleteFromDatabase({
  //   required StreamController<PsResource<List<dynamic>>> streamController,
  //   required dynamic obj,
  // }) async {
  //   await delete(obj);
  //   await startResourceSinkingForListFromDataBase(
  //     dao: _searchHistoryDao,
  //     streamController: streamController,
  //   );
  // }
}
