import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/user_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/user.dart';
import 'Common/ps_repository.dart';

class AgentRepository extends PsRepository {
  AgentRepository(
      {required PsApiService psApiService, required UserDao userDao}) {
    _psApiService = psApiService;
    _blogDao = userDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late UserDao _blogDao;

  Future<dynamic> insert(User blog) async {
    return _blogDao.insert(primaryKey, blog);
  }

  Future<dynamic> update(User blog) async {
    return _blogDao.update(blog);
  }

  Future<dynamic> delete(User blog) async {
    return _blogDao.delete(blog);
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
      dao: _blogDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getAgentList(
        requestPathHolder!.loginUserId,
        limit,
        offset,
        requestBodyHolder!.toMap(),
      ),
    );

    await subscribeDataList(
      dataListStream: streamController,
      dao: _blogDao,
      statusOnDataChange: PsStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
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
      dao: _blogDao,
      streamController: streamController,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getAgentList(
        requestPathHolder!.loginUserId,
        limit,
        offset,
        requestBodyHolder!.toMap(),
      ),
    );
  }
}
