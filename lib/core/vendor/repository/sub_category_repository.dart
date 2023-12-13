import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/sub_category_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/holder/sub_category_parameter_holder.dart';
import '../viewobject/sub_category.dart';
import 'Common/ps_repository.dart';

class SubCategoryRepository extends PsRepository {
  SubCategoryRepository(
      {required PsApiService psApiService,
      required SubCategoryDao subCategoryDao}) {
    _psApiService = psApiService;
    _subCategoryDao = subCategoryDao;
  }

  late PsApiService _psApiService;
  late SubCategoryDao _subCategoryDao;
  final String _primaryKey = 'id';

  Future<dynamic> insert(SubCategory subCategory) async {
    return _subCategoryDao.insert(_primaryKey, subCategory);
  }

  Future<dynamic> update(SubCategory subCategory) async {
    return _subCategoryDao.update(subCategory);
  }

  Future<dynamic> delete(SubCategory subCategory) async {
    return _subCategoryDao.delete(subCategory);
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
    final SubCategoryParameterHolder holder =
        requestBodyHolder as SubCategoryParameterHolder;
    final Finder finder = Finder(filter: Filter.equals('category_id', holder.catId));
    await startResourceSinkingForList(
      dao: _subCategoryDao,
      streamController: streamController,
      dataConfig: dataConfig,
      finder: finder,
      serverRequestCallback: () => _psApiService.getSubCategoryList(
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
    final SubCategoryParameterHolder holder =
        requestBodyHolder as SubCategoryParameterHolder;
    final Finder finder = Finder(filter: Filter.equals('category_id', holder.catId));
    await startResourceSinkingForNextList(
      dao: _subCategoryDao,
      streamController: streamController,
      dataConfig: dataConfig,
      finder: finder,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () => _psApiService.getSubCategoryList(
        requestBodyHolder.toMap(),
        requestPathHolder!.loginUserId,
        limit,
        offset,
        requestPathHolder.languageCode ?? 'en'
      ),
    );
  }

  // Future<dynamic> getSubCategoryListByCategoryId(
  //     StreamController<PsResource<List<SubCategory>>> subCategoryListStream,
  //     bool isConnectedToIntenet,
  //     Map<dynamic, dynamic> jsonMap,
  //     String? loginUserId,
  //     String? categoryId,
  //     int limit,
  //     int? offset,
  //     PsStatus status,
  //     {bool isLoadFromServer = true}) async {
  //   final Finder finder = Finder(filter: Filter.equals('cat_id', categoryId));

  //   subCategoryListStream.sink
  //       .add(await _subCategoryDao.getAll(status: status, finder: finder));

  //   if (isConnectedToIntenet) {
  //     final PsResource<List<SubCategory>> _resource = await _psApiService
  //         .getSubCategoryList(jsonMap, loginUserId, limit, offset);

  //     if (_resource.status == PsStatus.SUCCESS) {
  //       await _subCategoryDao.deleteWithFinder(finder);
  //       // await _subCategoryDao.deleteAll();
  //       await _subCategoryDao.insertAll(_primaryKey, _resource.data!);
  //     } else {
  //       if (_resource.errorCode == PsConst.ERROR_CODE_10001) {
  //         await _subCategoryDao.deleteWithFinder(finder);
  //         //  await _subCategoryDao.deleteAll();
  //       }
  //     }
  //     subCategoryListStream.sink
  //         .add(await _subCategoryDao.getAll(finder: finder));
  //   }
  // }

  // Future<dynamic> getAllSubCategoryListByCategoryId(
  //     StreamController<PsResource<List<SubCategory>>> subCategoryListStream,
  //     bool isConnectedToIntenet,
  //     PsStatus status,
  //     Map<dynamic, dynamic> jsonMap,
  //     String loginUserId,
  //     String categoryId,
  //     {bool isLoadFromServer = true}) async {
  //   final Finder finder = Finder(filter: Filter.equals('cat_id', categoryId));

  //   subCategoryListStream.sink
  //       .add(await _subCategoryDao.getAll(status: status, finder: finder));

  //   final PsResource<List<SubCategory>> _resource =
  //       await _psApiService.getAllSubCategoryList(jsonMap, loginUserId);

  //   if (_resource.status == PsStatus.SUCCESS) {
  //     await _subCategoryDao.deleteWithFinder(finder);
  //     await _subCategoryDao.insertAll(_primaryKey, _resource.data!);
  //   } else {
  //     if (_resource.errorCode == PsConst.ERROR_CODE_10001) {
  //       await _subCategoryDao.deleteWithFinder(finder);
  //     }
  //   }
  //   subCategoryListStream.sink
  //       .add(await _subCategoryDao.getAll(finder: finder));
  // }

  // Future<dynamic> getNextPageSubCategoryList(
  //     StreamController<PsResource<List<SubCategory>>> subCategoryListStream,
  //     bool isConnectedToIntenet,
  //     Map<dynamic, dynamic> jsonMap,
  //     String? loginUserId,
  //     int limit,
  //     int? offset,
  //     PsStatus status,
  //     {bool isLoadFromServer = true}) async {
  //   //  final Finder finder = Finder(filter: Filter.equals('cat_id', categoryId));
  //   subCategoryListStream.sink
  //       .add(await _subCategoryDao.getAll(status: status));

  //   final PsResource<List<SubCategory>> _resource = await _psApiService
  //       .getSubCategoryList(jsonMap, loginUserId, limit, offset);

  //   if (_resource.status == PsStatus.SUCCESS) {
  //     _subCategoryDao
  //         .insertAll(_primaryKey, _resource.data!)
  //         .then((dynamic data) async {
  //       subCategoryListStream.sink.add(await _subCategoryDao.getAll());
  //     });
  //   } else {
  //     subCategoryListStream.sink.add(await _subCategoryDao.getAll());
  //   }
  // }

  @override
  Future<dynamic> postData({
    required PsHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postSubCategorySubscribe(
          requestBodyHolder!.toMap(), 
          requestPathHolder?.loginUserId ?? 'nologinuser',
          requestPathHolder!.headerToken!,
          requestPathHolder.languageCode ?? 'en'
    );
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
