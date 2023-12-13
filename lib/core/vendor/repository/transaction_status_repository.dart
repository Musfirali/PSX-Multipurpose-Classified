import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/transaction_status_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/transaction_status.dart';
import 'Common/ps_repository.dart';

class TransactionStatusRepository extends PsRepository {
  TransactionStatusRepository(
      {required PsApiService psApiService,
      required TransactionStatusDao transactionStatusDao}) {
    _psApiService = psApiService;
    _transactionStatusDao = transactionStatusDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late TransactionStatusDao _transactionStatusDao;

  Future<dynamic> insert(TransactionStatus transactionStatus) async {
    return _transactionStatusDao.insert(primaryKey, transactionStatus);
  }

  Future<dynamic> update(TransactionStatus transactionStatus) async {
    return _transactionStatusDao.update(transactionStatus);
  }

  Future<dynamic> delete(TransactionStatus transactionStatus) async {
    return _transactionStatusDao.delete(transactionStatus);
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
      dao: _transactionStatusDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getTransactionStatusList(),
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
      dao: _transactionStatusDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getTransactionStatusList(),
    );
  }
}
