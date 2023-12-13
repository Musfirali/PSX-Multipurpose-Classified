import 'dart:async';
import 'package:sembast/sembast.dart';
import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/transaction_detail_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/transaction_detail.dart';
import 'Common/ps_repository.dart';

class TransactionDetailRepository extends PsRepository {
  TransactionDetailRepository(
      {required PsApiService psApiService,
      required TransactionDetailDao transactionDetailDao}) {
    _psApiService = psApiService;
    _transactionDetailDao = transactionDetailDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late TransactionDetailDao _transactionDetailDao;

  Future<dynamic> insert(TransactionDetail transaction) async {
    return _transactionDetailDao.insert(primaryKey, transaction);
  }

  Future<dynamic> update(TransactionDetail transaction) async {
    return _transactionDetailDao.update(transaction);
  }

  Future<dynamic> delete(TransactionDetail transaction) async {
    return _transactionDetailDao.delete(transaction);
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
      finder: Finder(
          filter: Filter.equals('transactions_header_id',
              requestPathHolder!.transactionHeaderId)),
      dao: _transactionDetailDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getTransactionList(
          requestPathHolder.transactionHeaderId!, limit, offset),
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
    await startResourceSinkingForList(
      finder: Finder(
          filter: Filter.equals('transactions_header_id',
              requestPathHolder!.transactionHeaderId)),
      dao: _transactionDetailDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getTransactionList(
          requestPathHolder.transactionHeaderId!, limit, offset),
    );
  }
}
