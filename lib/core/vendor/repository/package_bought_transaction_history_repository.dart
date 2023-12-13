import 'dart:async';
import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';

import '../db/common/ps_data_source_manager.dart';
import '../db/package_bought_transaction_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/buyadpost_transaction.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class PackageTranscationHistoryRepository extends PsRepository {
  PackageTranscationHistoryRepository(
      {required PsApiService psApiService,
      required PackageTransactionDao transactionDao}) {
    _psApiService = psApiService;
    _transactionDao = transactionDao;
  }

  String primaryKey = 'package_id';
  String mapKey = 'map_key';
  late PsApiService _psApiService;
  late PackageTransactionDao _transactionDao;

  Future<dynamic> insert(PackageTransaction transaction) async {
    return _transactionDao.insert(primaryKey, transaction);
  }

  Future<dynamic> update(PackageTransaction transaction) async {
    return _transactionDao.update(transaction);
  }

  Future<dynamic> delete(PackageTransaction transaction) async {
    return _transactionDao.delete(transaction);
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
      dao: _transactionDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () =>
          _psApiService.getPackageTransactionDetailList(
              requestBodyHolder!.toMap(), requestPathHolder!.loginUserId!, requestPathHolder.headerToken!,requestPathHolder.languageCode ?? 'en'),
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
      dao: _transactionDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () =>
          _psApiService.getPackageTransactionDetailList(
              requestBodyHolder!.toMap(), requestPathHolder!.loginUserId!, requestPathHolder.headerToken!,requestPathHolder.languageCode ?? 'en'),
    );
  }
    Future<PsResource<ApiStatus>> deletePacakgeHistoryList( Map<dynamic, dynamic> jsonMap,
      String? loginUserId, bool isConnectedToInternet, PsStatus status,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.deletePackageHistoryList(jsonMap, loginUserId!,languageCode);
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
