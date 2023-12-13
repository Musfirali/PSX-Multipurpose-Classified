import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/blog_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/blog.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class BlogRepository extends PsRepository {
  BlogRepository(
      {required PsApiService psApiService, required BlogDao blogDao}) {
    _psApiService = psApiService;
    _blogDao = blogDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late BlogDao _blogDao;

  Future<dynamic> insert(Blog blog) async {
    return _blogDao.insert(primaryKey, blog);
  }

  Future<dynamic> update(Blog blog) async {
    return _blogDao.update(blog);
  }

  Future<dynamic> delete(Blog blog) async {
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
        serverRequestCallback: () {
          if (requestPathHolder != null &&
              requestPathHolder.shopId != null) {
            return _psApiService.getBlogListByShopId(
              requestPathHolder.shopId!,
              limit,
              offset,
            );
          } else {
            return _psApiService.getBlogList(
              requestBodyHolder!.toMap(),
              requestPathHolder!.loginUserId!,
              limit,
              offset,
              requestPathHolder.languageCode ?? 'en'
            );
          }
        });

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
        dataConfig: dataConfig,
        loadingStatus: PsStatus.PROGRESS_LOADING,
        serverRequestCallback: () {
          if (requestPathHolder != null &&
              requestPathHolder.shopId != null) {
            return _psApiService.getBlogListByShopId(
              requestPathHolder.shopId!,
              limit,
              offset,
            );
          } else {
            return _psApiService.getBlogList(
              requestBodyHolder!.toMap(),
              requestPathHolder!.loginUserId!,
              limit,
              offset,
              requestPathHolder.languageCode ?? 'en'
            );
          }
        });
  }
}
