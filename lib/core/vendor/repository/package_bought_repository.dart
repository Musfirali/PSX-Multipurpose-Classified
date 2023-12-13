import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/package_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/package.dart';
import 'Common/ps_repository.dart';

class PackageBoughtRepository extends PsRepository {
  PackageBoughtRepository(
      {required PsApiService psApiService, required PackageDao packageDao}) {
    _psApiService = psApiService;
    _packageDao = packageDao;
  }
  String primaryKey = 'id';
  late PsApiService _psApiService;
  late PackageDao _packageDao;

  Future<dynamic> insert(Package package) async {
    return _packageDao.insert(primaryKey, package);
  }

  Future<dynamic> update(Package package) async {
    return _packageDao.update(package);
  }

  Future<dynamic> delete(Package package) async {
    return _packageDao.delete(package);
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
      dao: _packageDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getPackages(
          limit, offset, requestPathHolder?.loginUserId ?? 'nologinuser',requestPathHolder!.languageCode ?? 'en'),
    );
  }

  @override
  Future<PsResource<ApiStatus>> postData({
    required PsHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<ApiStatus> _resource = await _psApiService.buyAdPackage(
        requestBodyHolder!.toMap(),
        requestPathHolder?.loginUserId ?? 'nologinuser',
        requestPathHolder!.headerToken!,requestPathHolder.languageCode ?? 'en');
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
