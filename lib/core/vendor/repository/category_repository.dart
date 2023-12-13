import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/cateogry_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/api_status.dart';
import '../viewobject/category.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';

import 'Common/ps_repository.dart';

class CategoryRepository extends PsRepository {
  CategoryRepository(
      {required PsApiService psApiService, required CategoryDao categoryDao}) {
    _psApiService = psApiService;
    _categoryDao = categoryDao;
  }

  String primaryKey = 'cat_id';
  String mapKey = 'map_key';
  late PsApiService _psApiService;
  late CategoryDao _categoryDao;

  Future<dynamic> insert(Category category) async {
    return _categoryDao.insert(primaryKey, category);
  }

  Future<dynamic> update(Category category) async {
    return _categoryDao.update(category);
  }

  Future<dynamic> delete(Category category) async {
    return _categoryDao.delete(category);
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
      dao: _categoryDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getCategoryList(
        requestBodyHolder!.toMap(),
        requestPathHolder!.loginUserId!,
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
      dao: _categoryDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () => _psApiService.getCategoryList(
        requestBodyHolder!.toMap(),
        requestPathHolder!.loginUserId!,
        limit,
        offset,
        requestPathHolder.languageCode ?? 'en'
      ),
    );
  }

  @override
  Future<PsResource<ApiStatus>> postData({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postTouchCount(requestBodyHolder!.toMap(), requestPathHolder?.loginUserId ?? 'nologinuser', requestPathHolder?.languageCode ?? '');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  // Future<PsResource<ApiStatus>> postTouchCount(Map<dynamic, dynamic> jsonMap,
  //     bool isConnectedToInternet, PsStatus status,
  //     {bool isLoadFromServer = true}) async {
  //   final PsResource<ApiStatus> _resource =
  //       await _psApiService.postTouchCount(jsonMap);
  //   if (_resource.status == PsStatus.SUCCESS) {
  //     return _resource;
  //   } else {
  //     final Completer<PsResource<ApiStatus>> completer =
  //         Completer<PsResource<ApiStatus>>();
  //     completer.complete(_resource);
  //     return completer.future;
  //   }
  // }
}
