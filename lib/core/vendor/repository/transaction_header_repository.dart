import 'dart:async';
import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/transaction_header_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/transaction_header.dart';
import 'Common/ps_repository.dart';

class TransactionHeaderRepository extends PsRepository {
  TransactionHeaderRepository(
      {required PsApiService psApiService,
      required TransactionHeaderDao transactionHeaderDao}) {
    _psApiService = psApiService;
    _transactionHeaderDao = transactionHeaderDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late TransactionHeaderDao _transactionHeaderDao;

  Future<dynamic> insert(TransactionHeader transaction) async {
    return _transactionHeaderDao.insert(primaryKey, transaction);
  }

  Future<dynamic> update(TransactionHeader transaction) async {
    return _transactionHeaderDao.update(transaction);
  }

  Future<dynamic> delete(TransactionHeader transaction) async {
    return _transactionHeaderDao.delete(transaction);
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
          filter: Filter.equals('user_id', requestPathHolder!.loginUserId)),
      dao: _transactionHeaderDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getTransactionList(
          requestPathHolder.loginUserId!, limit, offset),
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
      finder: Finder(
          filter: Filter.equals('user_id', requestPathHolder!.loginUserId)),
      dao: _transactionHeaderDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getTransactionList(
          requestPathHolder.loginUserId!, limit, offset),
    );
  }

  // @override
  // Future<dynamic> postData({
  //   required PsHolder<dynamic>? requestBodyHolder,
  //   required RequestPathHolder? requestPathHolder,
  // }) async {
  //   final PsResource<TransactionHeader> _resource =
  //       await _psApiService.postTransactionSubmit(requestBodyHolder!.toMap());
  //   if (_resource.status == PsStatus.SUCCESS) {
  //     return _resource;
  //   } else {
  //     final Completer<PsResource<TransactionHeader>> completer =
  //         Completer<PsResource<TransactionHeader>>();
  //     completer.complete(_resource);
  //     return completer.future;
  //   }
  // }

  Future<PsResource<TransactionHeader>> postTransactionSubmit(
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final String jsonMapData = jsonMap.toString();
    print(jsonMapData);

    final PsResource<TransactionHeader> _resource =
        await _psApiService.postTransactionSubmit(jsonMap);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<TransactionHeader>> completer =
          Completer<PsResource<TransactionHeader>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<TransactionHeader>> postRefund(
    Map<dynamic, dynamic> jsonMap,
  ) async {
    final PsResource<TransactionHeader> _resource =
        await _psApiService.postRefund(jsonMap);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<TransactionHeader>> completer =
          Completer<PsResource<TransactionHeader>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
