import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/all_search_result_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class AllSearchResultRepository extends PsRepository {
  AllSearchResultRepository({
    required PsApiService apiService,
    required AllSearchResultDao searchResultDao,
  }) {
    _apiService = apiService;
    _searchResultDao = searchResultDao;
  }
  late PsApiService _apiService;
  late AllSearchResultDao _searchResultDao;

  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForOne(
      dao: _searchResultDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _apiService.getAllSearchResult(
          requestBodyHolder!.toMap(),
          requestPathHolder?.loginUserId ?? 'loginuserid',
          requestPathHolder?.languageCode ?? 'en'),
    );
  }
}
